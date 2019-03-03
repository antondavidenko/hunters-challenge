package phasergame.sceneobjects;

import model.PhaserGameModel.MobSpeed;
import model.PhaserGameModel.CharStartConfig;
import model.PhaserGameModel.MobLabel;
import model.PhaserGameModel.MobType;
import model.Model;
import phasergame.sceneobjects.Character;

class MobController {

    private var phaserScene:phaser.Scene;
    private var allMobList:Array<Character> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        phaserScene.load.spritesheet(MobType.MOB1LVL, 'assets/mob1lvl.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(MobType.MOB2LVL, 'assets/mob2lvl.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(MobType.MOB3LVL, 'assets/mob3lvl.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(MobType.MOB4LVL, 'assets/mob4lvl.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(MobType.MOB5LVL, 'assets/mob5lvl.png', { frameWidth: 32, frameHeight: 32 });
    }

    public function init() {
        for (mob in 0...Model.mobAmount) {
            var mobConfig:CharStartConfig = new CharStartConfig(
                MobType.MOB1LVL,
                Utils.getRandomScreenX(),
                Utils.getRandomScreenY(),
                MobLabel.MOB1LVL
            );
            var mob = new Character(phaserScene, mobConfig);
            mob.init();
            mob.setSpeed(MobSpeed.MOB1LVL);
            allMobList.push(mob);
        }

        for (currentMob in allMobList) {
            currentMob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        }

        var timer = new haxe.Timer(Model.mobTimeoutDelay);
        timer.run = function() {
            var randomChar:Character = allMobList[Std.random(allMobList.length)];
            randomChar.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        }
    }

    public function update(time:Float, delta:Float):Void {
        for (currentMob in allMobList) {
            currentMob.update(time, delta);
        }
    }

    public function getAllMobList():Array<Character> {
        return allMobList;
    }

    public function onMobSlayed(mobId:String):Void {
        var mob:Character = findMobById(mobId);
        if (mob != null) {
            mob.setXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            mob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        }

    }

    private function findMobById(mobId:String):Character {
        for (currentMob in allMobList) {
            if (currentMob.getPhysicBody().name == mobId) {
                return currentMob;
            }
        }
        return null;
    }
}