package phasergame.sceneobjects;

import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerData;
import model.DataTypes.PlayerType;
import model.DataTypes.CharStartConfig;
import model.PhaserGameModel;
import phasergame.sceneobjects.Character;

class PlayersCollection {

    private var phaserScene:phaser.Scene;
    private var allPlayersList:Array<Character> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        var frameSize:Int = 32;
        var frmeConfig:ImageFrameConfig = {frameWidth:frameSize, frameHeight:frameSize};
        phaserScene.load.spritesheet(PlayerType.SWORDMAN, 'assets/char_swordman.png', frmeConfig);
        PhaserGameModel.skinsCollection[PlayerType.SWORDMAN] = 3;
        phaserScene.load.spritesheet(PlayerType.BOWMAN, 'assets/char_bowman.png', frmeConfig);
        PhaserGameModel.skinsCollection[PlayerType.BOWMAN] = 3;
        phaserScene.load.spritesheet(PlayerType.ELF, 'assets/char_elf.png', frmeConfig);
        PhaserGameModel.skinsCollection[PlayerType.ELF] = 3;
        phaserScene.load.spritesheet(PlayerType.MAGE, 'assets/char_mage.png', frmeConfig);
        PhaserGameModel.skinsCollection[PlayerType.MAGE] = 3;
        phaserScene.load.spritesheet(PlayerType.HORSEMAN, 'assets/char_horseman.png', frmeConfig);
        PhaserGameModel.skinsCollection[PlayerType.HORSEMAN] = 3;
    }

    private function preparePlayerByConfig(config:CharStartConfig):Character {
        var player = new Character(phaserScene, config);
        player.init();
        allPlayersList.push(player);
        return player;
    }

    public function init(onReadyToMove:Array<Character> -> Void) {
        for (i in 0...6) {
            var playerConfig:CharStartConfig = PhaserGameModel.playersStartConfig[i];
            if (playerConfig != null && playerConfig.control != ControlType.NONE) {
                var player:Character = preparePlayerByConfig(playerConfig);
                PhaserGameModel.playersData[playerConfig.name] = getNewPlayerData(playerConfig.label, playerConfig.control, playerConfig.skin);
                var teamId:String = "team" + playerConfig.skin;
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

    public function getAllPlayersList():Array<Character> {
        return allPlayersList;
    }

    public function onPlayerSlayMob(playerId:String, mobLvl:Int):Void {
        PhaserGameModel.totalMobSlayedCounter++;
        var player:Character = findPlayerById(playerId);
        player.setCollisionState(function(player:Character){
            player.setIdle();
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
            playerData.expGained = (playerData.currentLevel == PhaserGameModel.maxLvl)?100:0;
            if (playerData.currentLevel > PhaserGameModel.maxLvlInGame) {
                PhaserGameModel.maxLvlInGame = playerData.currentLevel;
                PhaserGameModel.leaderPlayerLabel = playerData.label;
            }
        }
    }

    private function findPlayerById(playerId:String):Character {
        for (currentPlayer in allPlayersList) {
            if (currentPlayer.getPhysicBody().name == playerId) {
                return currentPlayer;
            }
        }
        return null;
    }
}