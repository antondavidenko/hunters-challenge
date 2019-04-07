package model;

import model.DataTypes.PlayerData;
import model.DataTypes.MobData;
import model.DataTypes.CharStartConfig;

class Model {
    static public var botSimpleTimeoutDelay:Int = 1000;
    static public var botHardTimeoutDelay:Int = 750;
    static public var mobTimeoutDelay:Int = 1000;

    static public var playersStartConfig:Array<CharStartConfig> = [];

    static public var mobAmount:Int;
    static public var maxLvl:Int;
    static public var maxLvlInGame:Int = 1;
    static public var baseExpGain:Float;
    static public var screenMode:String;
    static public var showLabel:Bool;
    static public var leaderPlayerLabel:String;
    static public var teamMode:Bool = false;

    static public var totalMobSlayedCounter = 0;

    static public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();
    static public var mobsData:Map<String, MobData> = new Map<String, MobData>();
    static public var skinsCollection:Map<String, Int> = new Map<String, Int>();

    static public function init():Void {
        mobAmount = MainMenuDefaultValues.mobAmount;
        maxLvl = DefaultValues.maxLvl;
        baseExpGain = MainMenuDefaultValues.baseExpGain;
        screenMode = MainMenuDefaultValues.screenMode;
        showLabel = MainMenuDefaultValues.showLabel;

        for (i in 0...6) {
            if (MainMenuDefaultValues.slots[i] != null ) {
                playersStartConfig.push(getCharStartConfigByDefaultValues(i));
            } else {
                break;
            }
        }
    }

    static private function getCharStartConfigByDefaultValues(id:Int):CharStartConfig {
        var charType:String = MainMenuDefaultValues.slots[id].charType;
        var name:String = MainMenuDefaultValues.slots[id].name;
        var label:String = MainMenuDefaultValues.slots[id].label;
        var x:Int = MainMenuDefaultValues.slots[id].x;
        var y:Int = MainMenuDefaultValues.slots[id].y;
        var control:String = MainMenuDefaultValues.slots[id].controlType;
        var skin:Int = MainMenuDefaultValues.slots[id].skin;
        return new CharStartConfig(charType, x, y, label, name, control, skin);
    }
}