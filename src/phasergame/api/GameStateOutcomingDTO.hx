package phasergame.api;

import phasergame.model.DefaultValues;
import phasergame.model.DataTypes.ControlType;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.PhaserGameModel;

class GameStateOutcomingDTO {

    public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();

    public function new() {
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