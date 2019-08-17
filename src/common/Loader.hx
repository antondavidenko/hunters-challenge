package common;

import js.Promise;
import haxe.Json;
import common.Localization;

class Loader {

    static private inline var PHASERGAME_CONFIG_JSON:String = "./data/phasergame_config.json";
    static private inline var MAINMENU_CONFIG_JSON:String = "./data/mainmenu_config.json";
    static private inline var LOCALIZATION_JSON:String = "./localization/en.json";

    static public function loadAll(onLoad:Void -> Void) {
        Promise.all([
            loadFile(PHASERGAME_CONFIG_JSON, phasergame.model.DefaultValues.setData),
            loadFile(MAINMENU_CONFIG_JSON, mainmenu.model.DefaultValues.setData),
            loadFile(LOCALIZATION_JSON, Localization.setData)
        ]).then( function(p:Dynamic) {
            onLoad();
        });
    }

    static private function loadFile(fileUrl:String, onLoad:Dynamic -> Void):Promise<Bool> {
        return new Promise(function(resolve, reject) {
            var http = new haxe.Http(fileUrl);

            http.onData = function(data:String) {
                onLoad(Json.parse(data));
                resolve(true);
            }

            http.onError = function(error) {
                trace('error: $error');
                reject(false);
            }

            http.request();
        });
    }

}