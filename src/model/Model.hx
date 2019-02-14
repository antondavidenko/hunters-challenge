package model;

import model.PhaserGameModel.CharData;
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
    static public var maxLvl:Int = 5;
    static public var baseExpGain:Float = 25;
    static public var screenMode:String = "";
    static public var showLabel:Bool = true;
    static public var totalMobSlayedCounter = 0;
    static public var playerData:CharData = new CharData(0,0,1);
    static public var bot1Data:CharData = new CharData(0,0,1);
    static public var bot2Data:CharData = new CharData(0,0,1);
    static public var bot3Data:CharData = new CharData(0,0,1);
    static public var bot4Data:CharData = new CharData(0,0,1);

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