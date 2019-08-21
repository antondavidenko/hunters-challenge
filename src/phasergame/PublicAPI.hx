package phasergame;

import phasergame.model.DataTypes.ControlType;
import phasergame.model.DefaultValues;
import phasergame.model.PhaserGameModel;
import phasergame.model.DataTypes.PlayerData;
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

class GameStateOutcomingDTO {

    public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();

    public function new () {
        for (itemId in PhaserGameModel.playersData.keys()) {
            if (isItemIdContainsTeamSuffix(itemId) && PhaserGameModel.teamMode) {
                playersData[itemId] = PhaserGameModel.playersData[itemId];
            } else if (!isItemIdContainsTeamSuffix(itemId) && !PhaserGameModel.teamMode && isEnabled(itemId)) {
                playersData[itemId] = PhaserGameModel.playersData[itemId];
            }
        }
    }

    private function isItemIdContainsTeamSuffix(itemId:String):Bool {
        return itemId.indexOf(DefaultValues.TEAM_SUFFIX) >= 0;
    }

    private function isEnabled(itemId:String):Bool {
        return PhaserGameModel.playersData[itemId].control != ControlType.NONE;
    }

}

class PhaserGameSignals {
    public static var gameEnd:Signal0 = new Signal0();
    public static var countUpFinish:Signal0 = new Signal0();
    public static var countUpProgress:Signal1<Int> = new Signal1();
    public static var mobSlayed:Signal1<Int> = new Signal1();
    public static var gameStateUpdate:Signal1<GameStateOutcomingDTO> = new Signal1();
}
