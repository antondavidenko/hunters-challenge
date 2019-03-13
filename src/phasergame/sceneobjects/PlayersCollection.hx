package phasergame.sceneobjects;

import model.PhaserGameModel.ControlType;
import model.PhaserGameModel.PlayerData;
import model.PhaserGameModel.PlayerType;
import model.PhaserGameModel.CharStartConfig;
import model.Model;
import phasergame.sceneobjects.Character;

class PlayersCollection {

    private var phaserScene:phaser.Scene;
    private var allPlayersList:Array<Character> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        phaserScene.load.spritesheet(PlayerType.SWORDMAN, 'assets/char_swordman.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(PlayerType.BOWMAN, 'assets/char_bowman.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(PlayerType.ELF, 'assets/char_elf.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(PlayerType.MAGE, 'assets/char_mage.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(PlayerType.HORSEMAN, 'assets/char_horseman.png', { frameWidth: 32, frameHeight: 32 });
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
            if (playerConfig.control != ControlType.NONE) {
                var player:Character = preparePlayerByConfig(playerConfig);
                Model.playersData[playerConfig.name] = new PlayerData(0, 0, 1, playerConfig.label, playerConfig.control);
            }
        }
        onReadyToMove(allPlayersList);
    }

    public function update(time:Float, delta:Float):Void {
        for (currentPlayer in allPlayersList) {
            currentPlayer.update(time, delta);
        }
    }

    public function getAllPlayersList():Array<Character> {
        return allPlayersList;
    }

    public function onPlayerSlayMob(playerId:String, mobLvl:Int):Void {
        Model.totalMobSlayedCounter++;
        updatePlayerDataOnMobSlayed(Model.playersData[playerId], mobLvl);
    }

    private function updatePlayerDataOnMobSlayed(playerData:PlayerData, mobLvl:Int):Void {
        playerData.slayedCounter++;
        playerData.expGained += Model.baseExpGain * mobLvl / playerData.currentLevel;
        if (playerData.expGained >= 100) {
            playerData.expGained = 0;
            playerData.currentLevel++;
            Model.maxLvlInGame = (Model.maxLvlInGame > playerData.currentLevel) ? Model.maxLvlInGame : playerData.currentLevel;
        }
    }
}