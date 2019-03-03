package phasergame.sceneobjects;

import model.PhaserGameModel.CharData;
import model.PhaserGameModel.CharType;
import model.PhaserGameModel.CharStartConfig;
import model.Model;
import phasergame.sceneobjects.Character;

class CharacterController {

    private var phaserScene:phaser.Scene;

    private var playerCharackter:Character;
    private var allCharacktersList:Array<Character> = [];

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        phaserScene.load.spritesheet(CharType.SWORDMAN, 'assets/char_swordman.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(CharType.BOWMAN, 'assets/char_bowman.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(CharType.ELF, 'assets/char_elf.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(CharType.MAGE, 'assets/char_mage.png', { frameWidth: 32, frameHeight: 32 });
        phaserScene.load.spritesheet(CharType.HORSEMAN, 'assets/char_horseman.png', { frameWidth: 32, frameHeight: 32 });
    }

    private function prepareCharackterByConfig(config:CharStartConfig):Character {
        var character = new Character(phaserScene, config);
        character.init();
        allCharacktersList.push(character);
        return character;
    }

    public function init() {
        playerCharackter = prepareCharackterByConfig(Model.charsStartConfig[0]);
        Model.playerId = playerCharackter.getPhysicBody().name;

        for (i in 1...6) {
            var botCharackterConfig:CharStartConfig = Model.charsStartConfig[i];
            var bot:Character = prepareCharackterByConfig(botCharackterConfig);
            Model.botsId.push(bot.getPhysicBody().name);
        }

        for (currentCharackter in allCharacktersList) {
            if (currentCharackter != playerCharackter) {
                currentCharackter.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }

        var timer = new haxe.Timer(Model.botTimeoutDelay);
        timer.run = function() {
            var randomChar:Character = allCharacktersList[Std.random(allCharacktersList.length)];
            if (randomChar != playerCharackter) {
                randomChar.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    public function onPointerdown(pointer):Void {
        playerCharackter.setGoToXY(pointer.x, pointer.y);
    }

    public function update(time:Float, delta:Float):Void {
        for (currentCharackter in allCharacktersList) {
            currentCharackter.update(time, delta);
        }
    }

    public function getAllCharacktersList():Array<Character> {
        return allCharacktersList;
    }

    public function onCharackterSlayMob(charId:String, mobLvl:Int):Void {
        Model.totalMobSlayedCounter++;
        if (charId == Model.playerId) {updateCharakterDataOnMobSlayed(Model.charsData[0]);}
        else if (charId == Model.botsId[0]) {updateCharakterDataOnMobSlayed(Model.charsData[1]);}
        else if (charId == Model.botsId[1]) {updateCharakterDataOnMobSlayed(Model.charsData[2]);}
        else if (charId == Model.botsId[2]) {updateCharakterDataOnMobSlayed(Model.charsData[3]);}
        else if (charId == Model.botsId[3]) {updateCharakterDataOnMobSlayed(Model.charsData[4]);}
        else if (charId == Model.botsId[4]) {updateCharakterDataOnMobSlayed(Model.charsData[5]);}
    }

    private function updateCharakterDataOnMobSlayed(charData:CharData):Void {
        charData.slayedCounter++;
        charData.expGained += Model.baseExpGain;
        if (charData.expGained >= 100) {
            charData.expGained = 0;
            charData.currentLevel++;
        }
    }
}