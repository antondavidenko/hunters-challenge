package phasergame;

import phasergame.model.DataTypes.MovingObjectState;
import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

class GameConfigurationIncomingDTO {

    public var playersStartConfig:Array<MovingObjectState>;
    public var page:String;
    public var isFullscreen:Bool;

    public function new (playersStartConfig:Array<MovingObjectState>, page:String, isFullscreen:Bool) {
        this.playersStartConfig = playersStartConfig;
        this.page = page;
        this.isFullscreen = isFullscreen;
    }

}

class PhaserGameSignals {
    public static var gameEnd:Signal0 = new Signal0();
    public static var countUpFinish:Signal0 = new Signal0();
    public static var countUpProgress:Signal1<Int> = new Signal1();
    public static var mobSlayed:Signal1<Int> = new Signal1();
}
