package phasergame.sceneobjects;

import phasergame.model.DataTypes.ExpGainPoint;
import mainmenu.model.DefaultValues;
import phasergame.model.DefaultValues;
import phasergame.model.ConfigTypes.AssetsConfig;
import phaser.loader.filetypes.ImageFrameConfig;
import phasergame.model.DataTypes.ControlType;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.DataTypes.MovingObjectState;
import phasergame.model.PhaserGameModel;
import phasergame.sceneobjects.MovingObject;

class PlayersCollection {

    private var phaserScene:phaser.Scene;
    private var allPlayersList:Array<MovingObject> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var playersAssetsConfig:AssetsConfig = DefaultValues.getPlayersAssetsConfig();
        var frmeConfig:ImageFrameConfig = {frameWidth:playersAssetsConfig.frameSize, frameHeight:playersAssetsConfig.frameSize};
        for (asset in playersAssetsConfig.assetsList) {
            phaserScene.load.spritesheet(asset.id, asset.url, frmeConfig);
            PhaserGameModel.skinsCollection[asset.id] = playersAssetsConfig.skins;
        }
    }

    private function preparePlayerByConfig(state:MovingObjectState):MovingObject {
        var player = new MovingObject(phaserScene, state);
        player.init();
        allPlayersList.push(player);
        return player;
    }

    public function init(onReadyToMove:Array<MovingObject> -> Void) {
        for (i in 0...6) {
            var playerState:MovingObjectState = PhaserGameModel.playersStartConfig[i];
            if (playerState != null && playerState.control != ControlType.NONE) {
                var player:MovingObject = preparePlayerByConfig(playerState);
                player.setSpeed(DefaultValues.getGameplayConfig().playersSpeed);
                PhaserGameModel.playersData[playerState.id] = getNewPlayerData(playerState.label, playerState.control, playerState.skin, playerState.charType);
                var teamId:String = "team" + playerState.skin;
                if (PhaserGameModel.playersData[teamId] == null) {
                    PhaserGameModel.playersData[teamId] = getNewPlayerData(teamId, "", -1, "team");
                }
            }
        }
        onReadyToMove(allPlayersList);
    }

    private function getNewPlayerData(label:String, control:String, skin:Int, classId:String):PlayerData {
        return{
            slayedCounter: 0,
            expGained: 0,
            currentLevel: 1,
            label: label,
            control: control,
            teamId: skin,
            classId: classId
        };
    }

    public function update(time:Float, delta:Float):Void {
        for (currentPlayer in allPlayersList) {
            currentPlayer.update(time, delta);
        }
    }

    public function stopAll():Void {
        for (currentPlayer in allPlayersList) {
            currentPlayer.getPhysicBody().anims.pause();
        }
    }

    public function getAllPlayersList():Array<MovingObject> {
        return allPlayersList;
    }

    public function onPlayerSlayMob(playerId:String, mobLvl:Int):ExpGainPoint {
        PhaserGameModel.totalMobSlayedCounter++;
        var exp:Int;
        var player:MovingObject = findPlayerById(playerId);
        player.setCollisionState(function(player:MovingObject){
            player.setIdle();
            player.releaseCollisionState();
        });
        if (PhaserGameModel.teamMode) {
            var teamData:PlayerData =  PhaserGameModel.playersData[DefaultValues.TEAM_SUFFIX + PhaserGameModel.playersData[playerId].teamId];
            exp = updatePlayerDataOnMobSlayed(teamData, mobLvl);
        } else {
            exp = updatePlayerDataOnMobSlayed(PhaserGameModel.playersData[playerId], mobLvl);
        }
        return {x:Std.int(player.getPhysicBody().x), y:Std.int(player.getPhysicBody().y), exp:exp};
    }

    private function updatePlayerDataOnMobSlayed(playerData:PlayerData, mobLvl:Int):Int {
        playerData.slayedCounter++;
        var expGainedNow:Int = Std.int(PhaserGameModel.baseExpGain * mobLvl / playerData.currentLevel);
        playerData.expGained += expGainedNow;
        if (playerData.expGained >= 100) {
            playerData.currentLevel++;
            playerData.expGained -= 100;
            if (playerData.currentLevel > PhaserGameModel.maxLvlInGame) {
                PhaserGameModel.maxLvlInGame = playerData.currentLevel;
                PhaserGameModel.leaderPlayerLabel = playerData.label;
            }
        }
        return expGainedNow;
    }

    private function findPlayerById(playerId:String):MovingObject {
        for (currentPlayer in allPlayersList) {
            if (currentPlayer.getPhysicBody().name == playerId) {
                return currentPlayer;
            }
        }
        return null;
    }
}