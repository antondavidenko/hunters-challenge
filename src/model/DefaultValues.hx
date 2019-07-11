package model;

import model.ConfigTypes.GeneralConfig;
import model.ConfigTypes.MovingObjectConfig;
import model.ConfigTypes.AbstractCharacterAssetsConfig;
import model.ConfigTypes.MainMenuConfig;

class DefaultValues {
    static public var mobTypes:Array<String> = ["mob1lvl", "mob2lvl", "mob3lvl", "mob4lvl", "mob5lvl"];
    static public var mobLabels:Array<String> = ["lvl 1", "lvl 2", "lvl 3", "lvl 4", "lvl 5"];

    static public inline var objectsSmall:String = "objects_small";
    static public inline var objectsTree:String = "objects_tree";
    static public inline var objectsSmallAmount:Int = 100;
    static public inline var objectsTreeAmount:Int = 25;
    static public inline var objectsTreePositionRandomizer:Int = 100;
    static public var forestPoints:Array<Array<Int>> =
    [[100, 100], [300, 100], [500, 100], [700, 100],
    [100, 500], [300, 500], [500, 500], [700, 500]];

    static public var mobSpeeds:Array<Int> = [100, 5, 25, 300, 300];
    static public var maxMobLvlId = 4;

    static public inline var botSimpleTimeoutDelay:Int = 1000;
    static public inline var botHardTimeoutDelay:Int = 750;
    static public inline var mobTimeoutDelay:Int = 1000;

    static public inline var MaxMainMenuSize:Int = 622;

    static private var dataStorage:Dynamic;

    static public function setDataStorage(newDataStorage:Dynamic):Void {
       dataStorage = newDataStorage;
    }

    static public function getGeneralConfig():GeneralConfig {
        return dataStorage.General;
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