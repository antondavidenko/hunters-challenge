package phasergame.model;

class Localization {
    static private var localizationStorage:Map<String, String> = new Map();

    static public function get(key:String):String {
        return localizationStorage[key];
    }

    static public function set(key:String, value:String):Void {
        localizationStorage[key] = value;
    }
}
