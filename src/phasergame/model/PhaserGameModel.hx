package phasergame.model;

import phasergame.PublicAPI.GameConfigurationIncomingDTO;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.DataTypes.MobData;
import phasergame.model.DataTypes.MovingObjectState;

class PhaserGameModel {
    static public var playersStartConfig:Array<MovingObjectState> = [];

    static public var mobAmount:Int;
    static public var maxLvl:Int;
    static public var maxLvlInGame:Int = 1;
    static public var baseExpGain:Float;
    static public var isFullscreen:Bool;
    static public var showLabel:Bool;
    static public var leaderPlayerLabel:String;
    static public var teamMode:Bool = false;

    static public var totalMobSlayedCounter = 0;

    static public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();
    static public var mobsData:Map<String, MobData> = new Map<String, MobData>();
    static public var skinsCollection:Map<String, Int> = new Map<String, Int>();

    static public function init(configuration:GameConfigurationIncomingDTO):Void {
        maxLvl = DefaultValues.getGameplayConfig().maxLvl;

        baseExpGain = DefaultValues.getGameConfigurationParam("baseExpGain", configuration.page);
        showLabel = DefaultValues.getGameConfigurationParam("showLabel", configuration.page);
        mobAmount = DefaultValues.getGameConfigurationParam("mobAmount", configuration.page);
        teamMode = DefaultValues.getGameConfigurationParam("teamMode", configuration.page);

        isFullscreen = configuration.isFullscreen;
        playersStartConfig = configuration.playersStartConfig;
    }

}