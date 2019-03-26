package model;

import model.PhaserGameModel.PlayerData;
import model.PhaserGameModel.MobData;
import model.PhaserGameModel.CharacterConfig;
import model.PhaserGameModel.CharStartConfig;

class Model {
    static public var phaserGameWidth:Int = 950;
    static public var phaserGameHeight:Int = 654;

    static public var botSimpleTimeoutDelay:Int = 1000;
    static public var botHardTimeoutDelay:Int = 750;
    static public var mobTimeoutDelay:Int = 1000;

    static public var character:CharacterConfig = new CharacterConfig();
    static public var playersStartConfig:Array<CharStartConfig> = [];

    static public var mobAmount:Int;
    static public var maxLvl:Int;
    static public var maxLvlInGame:Int = 1;
    static public var baseExpGain:Float;
    static public var screenMode:String;
    static public var showLabel:Bool;
    static public var leaderPlayerLabel:String;

    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];
    static public var mobLabels:Array<String> = ["lvl 1", "lvl 2", "lvl 3", "lvl 4", "lvl 5"];
    static public var mobSpeeds:Array<Int> = [100, 5, 25, 300, 300];
    static public var maxMobLvlId = 4;

    static public var totalMobSlayedCounter = 0;

    static public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();
    static public var mobsData:Map<String, MobData> = new Map<String, MobData>();
    static public var skinsCollection:Map<String, Int> = new Map<String, Int>();

    static public function init():Void {
        character.MOVE_SPEED = 150;
        character.MIN_DISTANCE = 3;

        mobAmount = DefaultValues.mobAmount;
        maxLvl = DefaultValues.maxLvl;
        baseExpGain = DefaultValues.baseExpGain;
        screenMode = DefaultValues.screenMode;
        showLabel = DefaultValues.showLabel;

        for (i in 0...6) {
            if (DefaultValues.slots[i] != null ) {
                playersStartConfig.push(getCharStartConfigByDefaultValues(i));
            } else {
                break;
            }
        }
    }

    static private function getCharStartConfigByDefaultValues(id:Int):CharStartConfig {
        var charType:String = DefaultValues.slots[id].charType;
        var name:String = DefaultValues.slots[id].name;
        var label:String = DefaultValues.slots[id].label;
        var x:Int = DefaultValues.slots[id].x;
        var y:Int = DefaultValues.slots[id].y;
        var control:String = DefaultValues.slots[id].controlType;
        return new CharStartConfig(charType, x, y, label, name, control, 2);
    }
}