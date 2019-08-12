package ;

import haxe.Json;
import phasergame.model.Localization;
import phasergame.model.DefaultValues;

class Loader {
    static private var onLoadAll:Void -> Void;

    static public function loadAll(onLoad:Void -> Void) {
        onLoadAll = onLoad;
        loadFile("./data/phasergame_config.json", onConfigLoad);
    }

    static private function onConfigLoad(data:String) {
        DefaultValues.setDataStorage(Json.parse(data).configsList);
        loadFile('data/mainmenu_config.json',onMenuConfigLoad);
    }

    static private function onMenuConfigLoad(data:String) {
        mainmenu.model.DefaultValues.setConfigFromFileData(Json.parse(data));
        loadFile('./localization/en.json', onLocalizationLoad);
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