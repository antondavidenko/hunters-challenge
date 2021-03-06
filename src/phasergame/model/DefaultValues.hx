package phasergame.model;

import phasergame.model.DataTypes.GameConfiguration;
import phasergame.model.ConfigTypes.GameplayConfig;
import phasergame.model.ConfigTypes.LocationConfig;
import phasergame.model.ConfigTypes.GeneralConfig;
import phasergame.model.ConfigTypes.MovingObjectConfig;
import phasergame.model.ConfigTypes.AssetsConfig;

class DefaultValues {
    static public inline var TEAM_SUFFIX:String = "team";
    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];
    static private inline var DEFAULT_PROFILE:String = "default";
    static private var gameConfigurationList:Map<String, GameConfiguration> = new Map();

    static private var dataStorage:Dynamic;

    static public function setData(newDataStorage:Dynamic):Void {
        dataStorage = newDataStorage;
        var gameConfigurationList:Array<Dynamic> = newDataStorage.GameConfigurationList;
        for(dataObj in gameConfigurationList) {
            DefaultValues.gameConfigurationList[dataObj.profile] = dataObj.data;
        }
    }

    static public function getGeneralConfig():GeneralConfig {
        return dataStorage.General;
    }

    static public function getGameplayConfig():GameplayConfig {
        return dataStorage.Gameplay;
    }

    static public function getLocationConfig():LocationConfig {
        return dataStorage.Location;
    }

    static public function getLocationAssetsConfig():AssetsConfig {
        return dataStorage.LocationAssets;
    }

    static public function getMobsAssetsConfig():AssetsConfig {
        return dataStorage.MobsAssets;
    }

    static public function getPlayersAssetsConfig():AssetsConfig {
        return dataStorage.PlayersAssets;
    }

    static public function getMovingObjectConfig():MovingObjectConfig {
        return dataStorage.MovingObjectConfig;
    }

    static public function getGameConfigurationParam(field:String, profile:String):Dynamic {
        var targetProfileField:Dynamic = Reflect.field(gameConfigurationList[profile], field);
        var defaultProfileField:Dynamic = Reflect.field(gameConfigurationList[DEFAULT_PROFILE], field);
        return targetProfileField != null ? targetProfileField : defaultProfileField;
    }
}