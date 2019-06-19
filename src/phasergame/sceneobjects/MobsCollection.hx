package phasergame.sceneobjects;

import model.ConfigTypes.AbstractCharacterAssetsConfig;
import model.DefaultValues;
import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.CharStartConfig;
import model.PhaserGameModel;
import phasergame.sceneobjects.AbstractCharacter;

class MobsCollection {

    private var phaserScene:phaser.Scene;
    private var allMobList:Array<AbstractCharacter> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var mobsAssetsConfig:AbstractCharacterAssetsConfig = Utils.getDataStorage().configsList.MobsAssets;
        var frmeConfig:ImageFrameConfig = {frameWidth:mobsAssetsConfig.frameSize, frameHeight:mobsAssetsConfig.frameSize};
        for (asset in mobsAssetsConfig.assetsList) {
            phaserScene.load.spritesheet(asset.id, asset.url, frmeConfig);
            PhaserGameModel.skinsCollection[asset.id] = mobsAssetsConfig.skins;
        }
    }

    public function init(onReadyToMove:Array<AbstractCharacter> -> Void) {
        var lvlId:Int = 0;
        var mobId:Int = 1;
        for (mob in 0...PhaserGameModel.mobAmount) {
            var mobConfig:CharStartConfig = getMobConfigByLvl(lvlId, mobId);
            var mob = new AbstractCharacter(phaserScene, mobConfig);
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
            name: "m" + mobId,
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

    public function getAllMobList():Array<AbstractCharacter> {
        return allMobList;
    }

    public function onMobCollision(mobId:String):Bool {
        var mob:AbstractCharacter = findMobById(mobId);
        var mobSlayed:Bool = false;
        if (mob != null) {
            mobSlayed = !mob.isOnCollision();
            mob.setCollisionState(respawnMob);
        }
        return mobSlayed;
    }

    private function respawnMob(mob:AbstractCharacter) {
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

    private function findMobById(mobId:String):AbstractCharacter {
        for (currentMob in allMobList) {
            if (currentMob.getPhysicBody().name == mobId) {
                return currentMob;
            }
        }
        return null;
    }
}