package phasergame;

import model.Model;
import phasergame.sceneobjects.Character;

class MoverCharacters {

    private var allMobList:Array<Character> = [];
    private var allPlayersList:Array<Character> = [];

    public function new() {
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
            if (currentPlayer != allPlayersList[0]) {
                currentPlayer.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }

        var timer = new haxe.Timer(Model.botTimeoutDelay);
        timer.run = function() {
            var randomPlayer:Character = allPlayersList[Std.random(allPlayersList.length)];
            if (randomPlayer != allPlayersList[0]) {
                randomPlayer.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    public function onPointerdown(pointer):Void {
        allPlayersList[0].setGoToXY(pointer.x, pointer.y);
    }
}