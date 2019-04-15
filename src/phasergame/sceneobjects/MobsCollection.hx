package phasergame.sceneobjects;

import model.DefaultValues;
import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.MobData;
import model.DataTypes.CharStartConfig;
import model.PhaserGameModel;
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
        phaserScene.load.spritesheet(DefaultValues.mobTypes[0], 'assets/mob1lvl.png', frmeConfig);
        PhaserGameModel.skinsCollection[DefaultValues.mobTypes[0]] = 1;
        phaserScene.load.spritesheet(DefaultValues.mobTypes[1], 'assets/mob2lvl.png', frmeConfig);
        PhaserGameModel.skinsCollection[DefaultValues.mobTypes[1]] = 1;
        phaserScene.load.spritesheet(DefaultValues.mobTypes[2], 'assets/mob3lvl.png', frmeConfig);
        PhaserGameModel.skinsCollection[DefaultValues.mobTypes[2]] = 1;
        phaserScene.load.spritesheet(DefaultValues.mobTypes[3], 'assets/mob4lvl.png', frmeConfig);
        PhaserGameModel.skinsCollection[DefaultValues.mobTypes[3]] = 1;
        phaserScene.load.spritesheet(DefaultValues.mobTypes[4], 'assets/mob5lvl.png', frmeConfig);
        PhaserGameModel.skinsCollection[DefaultValues.mobTypes[4]] = 1;
    }

    public function init(onReadyToMove:Array<Character> -> Void) {
        var lvlId:Int = 0;
        var mobId:Int = 1;
        for (mob in 0...PhaserGameModel.mobAmount) {
            var mobConfig:CharStartConfig = getMobConfigByLvl(lvlId, mobId);
            var mob = new Character(phaserScene, mobConfig);
            mob.init();
            mob.setSpeed(DefaultValues.mobSpeeds[lvlId]);
            allMobList.push(mob);
            PhaserGameModel.mobsData[mob.getPhysicBody().name] = {currentLevel:1};
            mobId++;
        }

        onReadyToMove(allMobList);
    }

    private function getMobConfigByLvl(lvlId:Int, mobId:Int):CharStartConfig {
        var mobX:Int = Utils.getRandomScreenX();
        var mobY:Int = Utils.getRandomScreenY();
        return {
            label: "",
            charType: DefaultValues.mobTypes[lvlId],
            control: ControlType.BOT_SIMPLE,
            x: mobX,
            y: mobY,
            name: "m"+mobId,
            skin: 1
        };
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

    public function onMobCollision(mobId:String):Bool {
        var mob:Character = findMobById(mobId);
        var mobSlayed:Bool = false;
        if (mob != null) {
            mobSlayed = !mob.isOnCollision();
            mob.setCollisionState(respawnMob);
        }
        return mobSlayed;
    }

    private function respawnMob(mob:Character) {
        var lvlId:Int = Std.random(PhaserGameModel.maxLvlInGame + 1);
        lvlId = (lvlId > DefaultValues.maxMobLvlId) ? DefaultValues.maxMobLvlId : lvlId;
        var mobConfig:CharStartConfig = getMobConfigByLvl(lvlId, 0);
        mob.reinit(mobConfig);
        mob.setSpeed(DefaultValues.mobSpeeds[lvlId]);
        mob.setXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        mob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        mob.releaseCollisionState();
        PhaserGameModel.mobsData[mob.getPhysicBody().name].currentLevel = lvlId + 1;
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