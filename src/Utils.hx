package ;

import model.DataTypes.PlayerColor;
import model.DefaultValues;

class Utils {
    static public function distanceBetween(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        var dx:Float = x1 - x2;
        var dy:Float = y1 - y2;

        return Math.sqrt(dx * dx + dy * dy);
    }

    static public function getRandomScreenX():Int {
        return Std.random(DefaultValues.phaserGameWidth);
    }

    static public function getRandomScreenY():Int {
        return Std.random(DefaultValues.phaserGameHeight);
    }

    static public function getSkinByColor(color:String):Int {
        switch color {
            case PlayerColor.RED: return 1;
            case PlayerColor.GREEN: return 2;
            default: return 3;
        }
    }

    static public function getColorBySkin(skin:Int):String {
        switch skin {
            case 1: return PlayerColor.RED;
            case 2: return PlayerColor.GREEN;
            default: return PlayerColor.BLUE;
        }
    }

    static private var dataStorage:Dynamic;

    static public function loadConfig(configUrl:String, onLoad:Void->Void) {

        var http = new haxe.Http(configUrl);

        http.onData = function (data:String) {
            dataStorage = haxe.Json.parse(data);
            parseDataTypes();
            onLoad();
        }

        http.onError = function (error) {
            trace('error: $error');
        }

        http.request();
    }

    static public function getDataStorage():Dynamic {
        return dataStorage;
    }

    static private function parseDataTypes() {
        parseAbstractCharacterAssetsConfig(dataStorage.configsList.PlayersAssets);
        parseAbstractCharacterAssetsConfig(dataStorage.configsList.MobsAssets);
        parseGameConfiguration(dataStorage.configsList.MainMenu.DefaultGameConfiguration);
    }

    static private function parseAbstractCharacterAssetsConfig(assetsConfig:Dynamic) {
        assetsConfig.frameSize = Std.parseInt(assetsConfig.frameSize);
        assetsConfig.skins = Std.parseInt(assetsConfig.skins);
    }

    static private function parseGameConfiguration(config:Dynamic) {
      config.showLabel = config.showLabel == "true";
        config.baseExpGain = Std.parseInt(config.baseExpGain);
        config.teamMode = config.teamMode == "true";
        config.mobAmount = Std.parseInt(config.mobAmount);
    }
}
