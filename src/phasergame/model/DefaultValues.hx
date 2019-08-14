package phasergame.model;

import phasergame.model.ConfigTypes.GameplayConfig;
import phasergame.model.ConfigTypes.LocationConfig;
import phasergame.model.ConfigTypes.GeneralConfig;
import phasergame.model.ConfigTypes.MovingObjectConfig;
import phasergame.model.ConfigTypes.AssetsConfig;
import phasergame.model.ConfigTypes.MainMenuConfig;

class DefaultValues {
    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];

    static private var dataStorage:Dynamic;

    static public function setData(newDataStorage:Dynamic):Void {
       dataStorage = newDataStorage;
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

    static public function getMainMenuConfig():MainMenuConfig {
        return dataStorage.MainMenu;
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
}