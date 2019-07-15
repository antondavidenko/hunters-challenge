package ;

import model.Localization;
import model.DataTypes.PlayerColor;
import model.DefaultValues;

class Utils {
    static public function distanceBetween(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        var dx:Float = x1 - x2;
        var dy:Float = y1 - y2;

        return Math.sqrt(dx * dx + dy * dy);
    }

    static public function getRandomScreenX():Int {
        return Std.random(DefaultValues.getGeneralConfig().phaserGameWidth);
    }

    static public function getRandomScreenY():Int {
        return Std.random(DefaultValues.getGeneralConfig().phaserGameHeight);
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
}

class Loader {
    static private var onLoadAll:Void -> Void;

    static public function loadConfig(configUrl:String, onLoad:Void -> Void) {
        onLoadAll = onLoad;
        loadFile(configUrl, onConfigLoad);
    }

    static private function onConfigLoad(data:String) {
        DefaultValues.setDataStorage(DataParser.parse(haxe.Json.parse(data).configsList));
        loadFile(DefaultValues.getGeneralConfig().localizationFile, onLocalizationLoad);
    }

    static private function onLocalizationLoad(data:String) {
        var parse = haxe.Json.parse(data).texts;
        for(field in Reflect.fields(parse)) {
            Localization.set(field, Reflect.field(parse, field));
        }
        onLoadAll();
    }

    static private function loadFile(fileUrl:String, onLoad:String -> Void) {

        var http = new haxe.Http(fileUrl);

        http.onData = function(data:String) {
            onLoad(data);
        }

        http.onError = function(error) {
            trace('error: $error');
        }

        http.request();
    }
}

class DataParser {
    static public function parse(data:Dynamic):Dynamic {
        parseCharactersAssetsConfig(data.PlayersAssets);
        parseCharactersAssetsConfig(data.MobsAssets);
        parseGameConfiguration(data.MainMenu.defaultGameConfiguration);
        parseGeneral(data.General);
        return data;
    }

    static private function parseCharactersAssetsConfig(assetsConfig:Dynamic) {
        assetsConfig.frameSize = Std.parseInt(assetsConfig.frameSize);
        assetsConfig.skins = Std.parseInt(assetsConfig.skins);
    }

    static private function parseGameConfiguration(config:Dynamic) {
        config.showLabel = config.showLabel == "true";
        config.baseExpGain = Std.parseInt(config.baseExpGain);
        config.teamMode = config.teamMode == "true";
        config.mobAmount = Std.parseInt(config.mobAmount);
    }

    static private function parseGeneral(config:Dynamic) {
        config.phaserGameWidth = Std.parseInt(config.phaserGameWidth);
        config.phaserGameHeight = Std.parseInt(config.phaserGameHeight);
        config.maxLvl = Std.parseInt(config.maxLvl);
    }
}