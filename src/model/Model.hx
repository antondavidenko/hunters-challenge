package model;

import model.PhaserGameModel.CharType;
import model.PhaserGameModel.CharacterConfig;
import model.PhaserGameModel.CharStartConfig;

class Model {
    static public var phaserGameWidth:Int = 950;
    static public var phaserGameHeight:Int = 654;

    static public var botTimeoutDelay:Int = 1000;
    static public var mobTimeoutDelay:Int = 100;
    static public var MOB_LVL_1_SPEED = 25;
    static public var MOB_LVL_2_SPEED = 50;
    static public var MOB_LVL_3_SPEED = 100;
    static public var MOB_LVL_4_SPEED = 200;
    static public var MOB_LVL_5_SPEED = 300;

    static public var Character:CharacterConfig = new CharacterConfig();
    static public var startBootsConfig:Array<CharStartConfig> = [];
    static public var startPlayerConfig:CharStartConfig;

    static public var mobAmount:Int = 5;
    static public var totalMobSlayedCounter = 0;
    static public var playerMobSlayedCounter = 0;
    static public var bot1MobSlayedCounter = 0;
    static public var bot2MobSlayedCounter = 0;
    static public var bot3MobSlayedCounter = 0;
    static public var bot4MobSlayedCounter = 0;

    static public var playerId:String = "";
    static public var botsId:Array<String> = [];

    static public function init():Void {
        Character.DEFAULT_POSE_ID = 7;
        Character.MOVE_SPEED = 150;
        Character.MIN_DISTANCE = 3;

        startPlayerConfig = new CharStartConfig(CharType.HORSEMAN, 400, 300, "Player");
        startBootsConfig.push(new CharStartConfig(CharType.SWORDMAN, 200, 300, "bot 1"));
        startBootsConfig.push(new CharStartConfig(CharType.SWORDMAN, 300, 300, "bot 2"));
        startBootsConfig.push(new CharStartConfig(CharType.SWORDMAN, 500, 300, "bot 3"));
        startBootsConfig.push(new CharStartConfig(CharType.SWORDMAN, 600, 300, "bot 4"));
    }
}