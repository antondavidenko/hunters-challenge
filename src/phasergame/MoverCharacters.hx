package phasergame;

import phaser.CursorKeys;
import model.PhaserGameModel.ControlType;
import model.Model;
import phasergame.sceneobjects.Character;

class MoverCharacters {

    private var allMobList:Array<Character> = [];
    private var allPlayersList:Array<Character> = [];
    private var keys:Dynamic;
    private var cursor:CursorKeys;

    public function new() {}

    public function setKeys(keys:Dynamic) {
        this.keys = keys;
    }

    public function setCursor(cursor:CursorKeys) {
        this.cursor = cursor;
    }

    public function initMobs(allMobList:Array<Character>) {
        this.allMobList = allMobList;

        for (currentMob in allMobList) {
            currentMob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        }

        var timer = new haxe.Timer(Model.mobTimeoutDelay);
        timer.run = function() {
            var randomMob:Character = allMobList[Std.random(allMobList.length)];
            randomMob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        }
    }

    public function initPlayers(allPlayersList:Array<Character>) {
        this.allPlayersList = allPlayersList;

        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (Model.playersData[id].control == ControlType.BOT_SIMPLE) {
                currentPlayer.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }

        var timer = new haxe.Timer(Model.botTimeoutDelay);
        timer.run = function() {
            var randomPlayer:Character = allPlayersList[Std.random(allPlayersList.length)];
            var id:String = randomPlayer.getPhysicBody().name;
            if (Model.playersData[id].control == ControlType.BOT_SIMPLE) {
                randomPlayer.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    public function onPointerdown(pointer):Void {
        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (Model.playersData[id].control == ControlType.MOUSE) {
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
        var axis:Int = (isPositive)?delta:0;
        return (isNegative)?-1*delta:axis;
    }

    private function onControlKeysPressed(deltaX:Int, deltaY:Int, keysFlag:String):Void {
        for (currentPlayer in allPlayersList) {
            var id:String = currentPlayer.getPhysicBody().name;
            if (Model.playersData[id].control == keysFlag) {
                var targetX:Int = Std.int(currentPlayer.getPhysicBody().x) + deltaX;
                var targetY:Int = Std.int(currentPlayer.getPhysicBody().y) + deltaY;
                currentPlayer.setGoToXY(targetX, targetY);
            }
        }
    }
}