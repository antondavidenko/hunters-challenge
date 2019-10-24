package phasergame.api;

import phasergame.model.DataTypes.MovingObjectState;

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
