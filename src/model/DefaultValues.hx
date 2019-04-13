package model;

import model.DataTypes.CharacterConfig;

class DefaultValues {
    static public inline var phaserGameWidth:Int = 950;
    static public inline var phaserGameHeight:Int = 654;

    static public var characterConfig:CharacterConfig = {
        MOVE_SPEED:150,
        MIN_DISTANCE:3,
        IDLE_POSE_ID:1,
        COLISION_ANIM_ID:2
    };

    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];
    static public var mobLabels:Array<String> = ["lvl 1", "lvl 2", "lvl 3", "lvl 4", "lvl 5"];
    static public var mobSpeeds:Array<Int> = [100, 5, 25, 300, 300];
    static public var maxMobLvlId = 4;

    static public inline var maxLvl:Int = 5;
    static public inline var screenMode:String = "";
    static public inline var showLabel:Bool = true;
    static public inline var baseExpGain:Float = 25;

    static public inline var botSimpleTimeoutDelay:Int = 1000;
    static public inline var botHardTimeoutDelay:Int = 750;
    static public inline var mobTimeoutDelay:Int = 1000;

    static public inline var MaxMainMenuSize:Int = 622;
}
