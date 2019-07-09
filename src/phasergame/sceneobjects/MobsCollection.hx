package phasergame.sceneobjects;

import model.ConfigTypes.AbstractCharacterAssetsConfig;
import model.DefaultValues;
import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.MovingObjectState;
import model.PhaserGameModel;
import phasergame.sceneobjects.MovingObject;

class MobsCollection {

    private var phaserScene:phaser.Scene;
    private var allMobList:Array<MovingObject> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var mobsAssetsConfig:AbstractCharacterAssetsConfig = Utils.getDataStorage().MobsAssets;
        var frmeConfig:ImageFrameConfig = {frameWidth:mobsAssetsConfig.frameSize, frameHeight:mobsAssetsConfig.frameSize};
        for (asset in mobsAssetsConfig.assetsList) {
            phaserScene.load.spritesheet(asset.id, asset.url, frmeConfig);
            PhaserGameModel.skinsCollection[asset.id] = mobsAssetsConfig.skins;
        }
    }

    public function init(onReadyToMove:Array<MovingObject> -> Void) {
        var lvlId:Int = 0;
        var mobId:Int = 1;
        for (mob in 0...PhaserGameModel.mobAmount) {
            var mobState:MovingObjectState = createMobStateByLvl(lvlId, mobId);
            var mob = new MovingObject(phaserScene, mobState);
            mob.init();
            mob.setSpeed(DefaultValues.mobSpeeds[lvlId]);
            allMobList.push(mob);
            PhaserGameModel.mobsData[mob.getPhysicBody().name] = {currentLevel:1};
            mobId++;
        }

        onReadyToMove(allMobList);
    }

    private function createMobStateByLvl(lvlId:Int, mobId:Int):MovingObjectState {
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

    public function getAllMobList():Array<MovingObject> {
        return allMobList;
    }

    public function onMobCollision(mobId:String):Bool {
        var mob:MovingObject = findMobById(mobId);
        var mobSlayed:Bool = false;
        if (mob != null) {
            mobSlayed = !mob.isOnCollision();
            mob.setCollisionState(respawnMob);
        }
        return mobSlayed;
    }

    private function respawnMob(mob:MovingObject) {
        var lvlId:Int = Std.random(PhaserGameModel.maxLvlInGame + 1);
        lvlId = (lvlId > DefaultValues.maxMobLvlId) ? DefaultValues.maxMobLvlId : lvlId;
        var mobState:MovingObjectState = createMobStateByLvl(lvlId, 0);
        mob.reinit(mobState);
        mob.setSpeed(DefaultValues.mobSpeeds[lvlId]);
        mob.setXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        mob.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
        mob.releaseCollisionState();
        PhaserGameModel.mobsData[mob.getPhysicBody().name].currentLevel = lvlId + 1;
    }

    private function findMobById(mobId:String):MovingObject {
        for (currentMob in allMobList) {
            if (currentMob.getPhysicBody().name == mobId) {
                return currentMob;
            }
        }
        return null;
    }
}