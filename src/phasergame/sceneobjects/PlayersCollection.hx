package phasergame.sceneobjects;

import model.ConfigTypes.AbstractCharacterAssetsConfig;
import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerData;
import model.DataTypes.MovingObjectState;
import model.PhaserGameModel;
import phasergame.sceneobjects.MovingObject;

class PlayersCollection {

    private var phaserScene:phaser.Scene;
    private var allPlayersList:Array<MovingObject> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var playersAssetsConfig:AbstractCharacterAssetsConfig = Utils.getDataStorage().configsList.PlayersAssets;
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
                PhaserGameModel.playersData[playerState.name] = getNewPlayerData(playerState.label, playerState.control, playerState.skin);
                var teamId:String = "team" + playerState.skin;
                if (PhaserGameModel.playersData[teamId] == null) {
                    PhaserGameModel.playersData[teamId] = getNewPlayerData(teamId, "", -1);
                }
            }
        }
        onReadyToMove(allPlayersList);
    }

    private function getNewPlayerData(label:String, control:String, skin:Int):PlayerData {
        return{
            slayedCounter: 0,
            expGained: 0,
            currentLevel: 1,
            label: label,
            control: control,
            teamId: skin
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

    public function onPlayerSlayMob(playerId:String, mobLvl:Int):Void {
        PhaserGameModel.totalMobSlayedCounter++;
        var player:MovingObject = findPlayerById(playerId);
        player.setCollisionState(function(player:MovingObject){
            player.setIdle();
            player.releaseCollisionState();
        });
        if (PhaserGameModel.teamMode) {
            var teamData:PlayerData =  PhaserGameModel.playersData["team" + PhaserGameModel.playersData[playerId].teamId];
            updatePlayerDataOnMobSlayed(teamData, mobLvl);
        } else {
            updatePlayerDataOnMobSlayed(PhaserGameModel.playersData[playerId], mobLvl);
        }
    }

    private function updatePlayerDataOnMobSlayed(playerData:PlayerData, mobLvl:Int):Void {
        playerData.slayedCounter++;
        playerData.expGained += PhaserGameModel.baseExpGain * mobLvl / playerData.currentLevel;
        if (playerData.expGained >= 100) {
            playerData.currentLevel++;
            playerData.expGained = 0;
            if (playerData.currentLevel > PhaserGameModel.maxLvlInGame) {
                PhaserGameModel.maxLvlInGame = playerData.currentLevel;
                PhaserGameModel.leaderPlayerLabel = playerData.label;
            }
        }
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