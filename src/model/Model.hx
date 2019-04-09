package model;

import model.DataTypes.Slot;
import model.DataTypes.GameConfiguration;
import model.DataTypes.PlayerData;
import model.DataTypes.MobData;
import model.DataTypes.CharStartConfig;

class Model {
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

    static public function init(configuration:GameConfiguration):Void {
        mobAmount = configuration.mobAmount;
        maxLvl = DefaultValues.maxLvl;
        baseExpGain = configuration.baseExpGain;
        screenMode = configuration.screenMode;
        showLabel = configuration.showLabel;

        for (i in 0...6) {
            if (configuration.slots[i] != null ) {
                playersStartConfig.push(getCharStartConfigByDefaultValues(i, configuration.slots));
            } else {
                break;
            }
        }
    }

    static private function getCharStartConfigByDefaultValues(id:Int, slots:Array<Slot>):CharStartConfig {
        var charType:String = slots[id].charType;
        var name:String = slots[id].name;
        var label:String = slots[id].label;
        var x:Int = slots[id].x;
        var y:Int = slots[id].y;
        var control:String = slots[id].controlType;
        var skin:Int = slots[id].skin;
        return new CharStartConfig(charType, x, y, label, name, control, skin);
    }
}