package ;

import model.Model;
class Utils {
    static public function distanceBetween(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        var dx:Float = x1 - x2;
        var dy:Float = y1 - y2;

        return Math.sqrt(dx * dx + dy * dy);
    }

    static public function getRandomScreenX():Int {
        return Std.random(Model.phaserGameWidth);
    }

    static public function getRandomScreenY():Int {
        return Std.random(Model.phaserGameHeight);
    }

    static private var uniqueId:Int = 0;
    static public function getUniqueId():String {
        uniqueId++;
        return Std.string(uniqueId);
    }
}
