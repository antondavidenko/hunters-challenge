package phasergame.sceneobjects;

import model.PhaserGameModel.CharData;
import model.PhaserGameModel.CharType;
import model.PhaserGameModel.CharStartConfig;
import model.Model;
import phasergame.sceneobjects.Character;

class CharacterController {

    private var phaserScene:phaser.Scene;
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
        for (i in 0...6) {
            var botCharackterConfig:CharStartConfig = Model.charsStartConfig[i];
            var bot:Character = prepareCharackterByConfig(botCharackterConfig);
            Model.playersData[bot.getPhysicBody().name] = new CharData(0,0,1);
        }

        for (currentCharackter in allCharacktersList) {
            if (currentCharackter != allCharacktersList[0]) {
                currentCharackter.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }

        var timer = new haxe.Timer(Model.botTimeoutDelay);
        timer.run = function() {
            var randomChar:Character = allCharacktersList[Std.random(allCharacktersList.length)];
            if (randomChar != allCharacktersList[0]) {
                randomChar.setGoToXY(Utils.getRandomScreenX(), Utils.getRandomScreenY());
            }
        }
    }

    public function onPointerdown(pointer):Void {
        allCharacktersList[0].setGoToXY(pointer.x, pointer.y);
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
        updateCharakterDataOnMobSlayed(Model.playersData[charId],mobLvl);
    }

    private function updateCharakterDataOnMobSlayed(charData:CharData, mobLvl:Int):Void {
        charData.slayedCounter++;
        charData.expGained += Model.baseExpGain*mobLvl/charData.currentLevel;
        if (charData.expGained >= 100) {
            charData.expGained = 0;
            charData.currentLevel++;
            Model.maxLvlInGame = (Model.maxLvlInGame>charData.currentLevel)?Model.maxLvlInGame:charData.currentLevel;
        }
    }
}