package phasergame;

import model.DefaultValues;
import phaser.input.keyboard.CursorKeys;
import model.DataTypes.ControlType;
import model.PhaserGameModel;
import phasergame.sceneobjects.AbstractCharacter;

class MoverCharacters {

    private var allMobList:Array<AbstractCharacter> = [];
    private var allPlayersList:Array<AbstractCharacter> = [];
    private var keys:Dynamic;
    private var cursor:CursorKeys;
    private var onPointerpressed:Bool = false;
    private var isPause:Bool = false;

    public function new() {}

    public function setPause(pause:Bool):Void {
        isPause = pause;
    }

    public function setKeys(keys:Dynamic) {
        this.keys = keys;
    }

    public function setCursor(cursor:CursorKeys) {
        this.cursor = cursor;
    }

    public function initMobs(allMobList:Array<AbstractCharacter>) {
        this.allMobList = allMobList;

        for (currentMob in allMobList) {
            simpleBotModel(currentMob, DefaultValues.mobTimeoutDelay);
        }
    }

    public function initPlayers(allPlayersList:Array<AbstractCharacter>) {
        this.allPlayersList = allPlayersList;

        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (PhaserGameModel.playersData[id].control == ControlType.BOT_SIMPLE) {
                simpleBotModel(currentPlayer, DefaultValues.botSimpleTimeoutDelay);
            } else if (PhaserGameModel.playersData[id].control == ControlType.BOT_HARD) {
                hardBotModel(currentPlayer, DefaultValues.botHardTimeoutDelay);
            }
        }
    }

    private function simpleBotModel(target:AbstractCharacter, delay:Int) {
        target.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        var timer = new haxe.Timer(Std.random(Std.int(delay / 2)) + Std.int(delay / 2));
        timer.run = function() {
            if (!isPause) {
                target.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    private function hardBotModel(target:AbstractCharacter, delay:Int) {
        var closestMob:AbstractCharacter = getClosestMob(target.getPhysicBody().x, target.getPhysicBody().y);
        target.setGoToXY(Std.int(closestMob.getPhysicBody().x), Std.int(closestMob.getPhysicBody().y));
        var timer = new haxe.Timer(Std.random(Std.int(delay / 2)) + Std.int(delay / 2));
        timer.run = function() {
            if (!isPause) {
                var closestMob:AbstractCharacter = getClosestMob(target.getPhysicBody().x, target.getPhysicBody().y);
                target.setGoToXY(Std.int(closestMob.getPhysicBody().x), Std.int(closestMob.getPhysicBody().y));
            }
        }
    }

    private function getClosestMob(x:Float, y:Float):AbstractCharacter {
        var result:AbstractCharacter = allMobList[0];
        var minDistanation:Float = Utils.distanceBetween(x, y, result.getPhysicBody().x, result.getPhysicBody().y);
        for (i in 0...allMobList.length) {
            var mob:AbstractCharacter = allMobList[i];
            var distanation:Float = Utils.distanceBetween(x, y, mob.getPhysicBody().x, mob.getPhysicBody().y);
            if (distanation < minDistanation) {
                minDistanation = distanation;
                result = mob;
            }
        }
        return result;
    }

    public function onPointerdown(pointer):Void {
        onPointerpressed = true;
        moveMouseTypedToPointer(pointer);
    }

    public function onPointerup(pointer):Void {
        onPointerpressed = false;
    }

    public function onPointermove(pointer):Void {
        if (onPointerpressed) {
            moveMouseTypedToPointer(pointer);
        }
    }

    private function moveMouseTypedToPointer(pointer):Void {
        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (PhaserGameModel.playersData[id].control == ControlType.MOUSE && !isPause) {
                currentPlayer.setGoToXY(pointer.x, pointer.y);
            }
        }
    }

    public function update():Void {
        checkAWSDKeys();
        checkCursorKeys();
    }

    private function checkAWSDKeys():Void {
        var deltaAWSDx:Int = defineCursorMoveAxis(keys.D.isDown, keys.A.isDown);
        var deltaAWSDy:Int = defineCursorMoveAxis(keys.S.isDown, keys.W.isDown);
        if (deltaAWSDx != 0 || deltaAWSDy != 0) { onControlKeysPressed(deltaAWSDx, deltaAWSDy, ControlType.AWSD); }
    }

    private function checkCursorKeys():Void {
        var deltaCursorX:Int = defineCursorMoveAxis(cursor.right.isDown, cursor.left.isDown);
        var deltaCursorY:Int = defineCursorMoveAxis(cursor.down.isDown, cursor.up.isDown);
        if (deltaCursorX != 0 || deltaCursorY != 0) { onControlKeysPressed(deltaCursorX, deltaCursorY, ControlType.ARROWS); }
    }

    private function defineCursorMoveAxis(isPositive:Bool, isNegative:Bool):Int {
        var delta:Int = 10;
        var axis:Int = (isPositive) ? delta : 0;
        return (isNegative) ? -1 * delta : axis;
    }

    private function onControlKeysPressed(deltaX:Int, deltaY:Int, keysFlag:String):Void {
        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (PhaserGameModel.playersData[id].control == keysFlag && !isPause) {
                var targetX:Int = Std.int(currentPlayer.getPhysicBody().x) + deltaX;
                var targetY:Int = Std.int(currentPlayer.getPhysicBody().y) + deltaY;
                currentPlayer.setGoToXY(targetX, targetY);
            }
        }
    }
}