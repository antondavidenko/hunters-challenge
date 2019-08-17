package common;

class Localization {

    static private var localizationStorage:Map<String, String> = new Map();

    static public function setData(data:Dynamic):Void {
        var texts:Array<Dynamic> = data.texts;
        for(field in Reflect.fields(texts)) {
            set(field, Reflect.field(texts, field));
        }
    }

    static public function get(key:String):String {
        return localizationStorage[key];
    }

    static private function set(key:String, value:String):Void {
        localizationStorage[key] = value;
    }

}