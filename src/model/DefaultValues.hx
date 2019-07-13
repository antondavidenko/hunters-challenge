package model;

import model.ConfigTypes.LocationConfig;
import model.ConfigTypes.GeneralConfig;
import model.ConfigTypes.MovingObjectConfig;
import model.ConfigTypes.AbstractCharacterAssetsConfig;
import model.ConfigTypes.MainMenuConfig;

class DefaultValues {
    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];
    static public var mobLabels:Array<String> = ["lvl 1", "lvl 2", "lvl 3", "lvl 4", "lvl 5"];
    static public var mobSpeeds:Array<Int> = [100, 5, 25, 300, 300];
    static public var maxMobLvlId = 4;
    static public inline var mobTimeoutDelay:Int = 1000;

    static public inline var botSimpleTimeoutDelay:Int = 1000;
    static public inline var botHardTimeoutDelay:Int = 750;

    static private var dataStorage:Dynamic;

    static public function setDataStorage(newDataStorage:Dynamic):Void {
       dataStorage = newDataStorage;
    }

    static public function getGeneralConfig():GeneralConfig {
        return dataStorage.General;
    }

    static public function getLocationConfig():LocationConfig {
        return dataStorage.Location;
    }

    static public function getMainMenuConfig():MainMenuConfig {
        return dataStorage.MainMenu;
    }

    static public function getMobsAssetsConfig():AbstractCharacterAssetsConfig {
        return dataStorage.MobsAssets;
    }

    static public function getPlayersAssetsConfig():AbstractCharacterAssetsConfig {
        return dataStorage.PlayersAssets;
    }

    static public function getMovingObjectConfig():MovingObjectConfig {
        return dataStorage.MovingObjectConfig;
    }
}