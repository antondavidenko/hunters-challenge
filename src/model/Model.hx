package model;

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

        for (slot in configuration.slots) {
            playersStartConfig.push(getCharStartConfigBySlotValue(slot));
        }
    }

    static private function getCharStartConfigBySlotValue(slot:CharStartConfig):CharStartConfig {
        return new CharStartConfig(slot.label, slot.charType, slot.control, slot.x,slot.y, slot.name, slot.skin);
    }
}