package phasergame.sceneobjects;

import phaser.loader.filetypes.ImageFrameConfig;
import model.PhaserGameModel.ControlType;
import model.PhaserGameModel.MobData;
import model.PhaserGameModel.CharStartConfig;
import model.Model;
import phasergame.sceneobjects.Character;

class MobsCollection {

    private var phaserScene:phaser.Scene;
    private var allMobList:Array<Character> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var frameSize:Int = 32;
        var frmeConfig:ImageFrameConfig = {frameWidth:frameSize, frameHeight:frameSize};
        phaserScene.load.spritesheet(Model.mobTypes[0], 'assets/mob1lvl.png', frmeConfig);
        Model.skinsCollection[Model.mobTypes[0]] = 1;
        phaserScene.load.spritesheet(Model.mobTypes[1], 'assets/mob2lvl.png', frmeConfig);
        Model.skinsCollection[Model.mobTypes[1]] = 1;
        phaserScene.load.spritesheet(Model.mobTypes[2], 'assets/mob3lvl.png', frmeConfig);
        Model.skinsCollection[Model.mobTypes[2]] = 1;
        phaserScene.load.spritesheet(Model.mobTypes[3], 'assets/mob4lvl.png', frmeConfig);
        Model.skinsCollection[Model.mobTypes[3]] = 1;
        phaserScene.load.spritesheet(Model.mobTypes[4], 'assets/mob5lvl.png', frmeConfig);
        Model.skinsCollection[Model.mobTypes[4]] = 1;
    }

    public function init(onReadyToMove:Array<Character> -> Void) {
        var lvlId:Int = 0;
        var mobId:Int = 1;
        for (mob in 0...Model.mobAmount) {
            var mobConfig:CharStartConfig = getMobConfigByLvl(lvlId, mobId);
            var mob = new Character(phaserScene, mobConfig);
            mob.init();
            mob.setSpeed(Model.mobSpeeds[lvlId]);
            allMobList.push(mob);
            Model.mobsData[mob.getPhysicBody().name] = new MobData(1);
            mobId++;
        }

        onReadyToMove(allMobList);
    }

    private function getMobConfigByLvl(lvlId:Int, mobId:Int):CharStartConfig {
        var mobX:Int = Utils.getRandomScreenX();
        var mobY:Int = Utils.getRandomScreenY();
        return new CharStartConfig(Model.mobTypes[lvlId], mobX, mobY, "", "m"+mobId, ControlType.BOT_SIMPLE, 1);
    }

    public function update(time:Float, delta:Float):Void {
        for (currentMob in allMobList) {
            currentMob.update(time, delta);
        }
    }

    public function stopAll():Void {
        for (currentMob in allMobList) {
            currentMob.getPhysicBody().anims.pause();
        }
    }

    public function getAllMobList():Array<Character> {
        return allMobList;
    }

    public function onMobSlayed(mobId:String):Void {
        var mob:Character = findMobById(mobId);
        if (mob != null) {
            var lvlId:Int = Std.random(Model.maxLvlInGame + 1);
            lvlId = (lvlId > Model.maxMobLvlId) ? Model.maxMobLvlId : lvlId;
            var mobConfig:CharStartConfig = getMobConfigByLvl(lvlId, 0);
            mob.reinit(mobConfig);
            mob.setSpeed(Model.mobSpeeds[lvlId]);
            mob.setXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            mob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            Model.mobsData[mob.getPhysicBody().name].currentLevel = lvlId + 1;
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