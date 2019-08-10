package phasergame.model;

import phasergame.model.DataTypes.GameConfiguration;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.DataTypes.MobData;
import phasergame.model.DataTypes.MovingObjectState;

class PhaserGameModel {
    static public var playersStartConfig:Array<MovingObjectState> = [];

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
        maxLvl = DefaultValues.getGameplayConfig().maxLvl;
        baseExpGain = configuration.baseExpGain;
        screenMode = configuration.screenMode;
        showLabel = configuration.showLabel;
        teamMode = configuration.teamMode;

        for (slot in configuration.slots) {
            playersStartConfig.push({
                label:slot.label,
                charType:slot.charType,
                control:slot.control,
                x:slot.x,
                y:slot.y,
                id:slot.id,
                skin:slot.skin
            });
        }
    }
}