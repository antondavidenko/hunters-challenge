package phasergame;

import phasergame.model.ConfigTypes.GameplayConfig;
import phasergame.model.DefaultValues;
import phaser.input.keyboard.CursorKeys;
import phasergame.model.DataTypes.ControlType;
import phasergame.model.PhaserGameModel;
import phasergame.sceneobjects.MovingObject;

class DirectionDefiner {

    private var allMobList:Array<MovingObject> = [];
    private var allPlayersList:Array<MovingObject> = [];
    private var keys:Dynamic;
    private var cursor:CursorKeys;
    private var onPointerpressed:Bool = false;
    private var isPause:Bool = false;
    private var config:GameplayConfig;

    public function new() {
        config = DefaultValues.getGameplayConfig();
    }

    public function setPause(pause:Bool):Void {
        isPause = pause;
    }

    public function setKeys(keys:Dynamic) {
        this.keys = keys;
    }

    public function setCursor(cursor:CursorKeys) {
        this.cursor = cursor;
    }

    public function initMobs(allMobList:Array<MovingObject>) {
        this.allMobList = allMobList;

        for (currentMob in allMobList) {
            simpleBotModel(currentMob, config.mobTimeoutDelay);
        }
    }

    public function initPlayers(allPlayersList:Array<MovingObject>) {
        this.allPlayersList = allPlayersList;

        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (PhaserGameModel.playersData[id].control == ControlType.BOT_SIMPLE) {
                simpleBotModel(currentPlayer, config.botSimpleTimeoutDelay);
            } else if (PhaserGameModel.playersData[id].control == ControlType.BOT_HARD) {
                hardBotModel(currentPlayer, config.botHardTimeoutDelay);
            }
        }
    }

    private function simpleBotModel(target:MovingObject, delay:Int) {
        target.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        var timer = new haxe.Timer(Std.random(Std.int(delay / 2)) + Std.int(delay / 2));
        timer.run = function() {
            if (!isPause) {
                target.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    private function hardBotModel(target:MovingObject, delay:Int) {
        var closestMob:MovingObject = getClosestMob(target.getPhysicBody().x, target.getPhysicBody().y);
        target.setGoToXY(Std.int(closestMob.getPhysicBody().x), Std.int(closestMob.getPhysicBody().y));
        var timer = new haxe.Timer(Std.random(Std.int(delay / 2)) + Std.int(delay / 2));
        timer.run = function() {
            if (!isPause) {
                var closestMob:MovingObject = getClosestMob(target.getPhysicBody().x, target.getPhysicBody().y);
                target.setGoToXY(Std.int(closestMob.getPhysicBody().x), Std.int(closestMob.getPhysicBody().y));
            }
        }
    }

    private function getClosestMob(x:Float, y:Float):MovingObject {
        var result:MovingObject = allMobList[0];
        var minDistanation:Float = Utils.distanceBetween(x, y, result.getPhysicBody().x, result.getPhysicBody().y);
        for (i in 0...allMobList.length) {
            var mob:MovingObject = allMobList[i];
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