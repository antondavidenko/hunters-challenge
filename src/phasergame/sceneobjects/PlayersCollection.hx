package phasergame.sceneobjects;

import phaser.loader.filetypes.ImageFrameConfig;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerData;
import model.DataTypes.PlayerType;
import model.DataTypes.CharStartConfig;
import model.Model;
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
        Model.skinsCollection[PlayerType.SWORDMAN] = 3;
        phaserScene.load.spritesheet(PlayerType.BOWMAN, 'assets/char_bowman.png', frmeConfig);
        Model.skinsCollection[PlayerType.BOWMAN] = 3;
        phaserScene.load.spritesheet(PlayerType.ELF, 'assets/char_elf.png', frmeConfig);
        Model.skinsCollection[PlayerType.ELF] = 3;
        phaserScene.load.spritesheet(PlayerType.MAGE, 'assets/char_mage.png', frmeConfig);
        Model.skinsCollection[PlayerType.MAGE] = 3;
        phaserScene.load.spritesheet(PlayerType.HORSEMAN, 'assets/char_horseman.png', frmeConfig);
        Model.skinsCollection[PlayerType.HORSEMAN] = 3;
    }

    private function preparePlayerByConfig(config:CharStartConfig):Character {
        var player = new Character(phaserScene, config);
        player.init();
        allPlayersList.push(player);
        return player;
    }

    public function init(onReadyToMove:Array<Character> -> Void) {
        for (i in 0...6) {
            var playerConfig:CharStartConfig = Model.playersStartConfig[i];
            if (playerConfig != null && playerConfig.control != ControlType.NONE) {
                var player:Character = preparePlayerByConfig(playerConfig);
                Model.playersData[playerConfig.name] = new PlayerData(0, 0, 1, playerConfig.label, playerConfig.control, playerConfig.skin);
                var teamId:String = "team" + playerConfig.skin;
                if (Model.playersData[teamId] == null) {
                    Model.playersData[teamId] = new PlayerData(0, 0, 1, teamId, "", -1);
                }
            }
        }
        onReadyToMove(allPlayersList);
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
        Model.totalMobSlayedCounter++;
        var player:Character = findPlayerById(playerId);
        player.setCollisionState(function(player:Character){
            player.setIdle();
        });
        if (Model.teamMode) {
            var teamData:PlayerData =  Model.playersData["team" + Model.playersData[playerId].teamId];
            updatePlayerDataOnMobSlayed(teamData, mobLvl);
        } else {
            updatePlayerDataOnMobSlayed(Model.playersData[playerId], mobLvl);
        }
    }

    private function updatePlayerDataOnMobSlayed(playerData:PlayerData, mobLvl:Int):Void {
        playerData.slayedCounter++;
        playerData.expGained += Model.baseExpGain * mobLvl / playerData.currentLevel;
        if (playerData.expGained >= 100) {
            playerData.currentLevel++;
            playerData.expGained = (playerData.currentLevel == Model.maxLvl)?100:0;
            if (playerData.currentLevel > Model.maxLvlInGame) {
                Model.maxLvlInGame = playerData.currentLevel;
                Model.leaderPlayerLabel = playerData.label;
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