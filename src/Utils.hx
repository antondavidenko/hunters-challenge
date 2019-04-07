package ;

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
}
