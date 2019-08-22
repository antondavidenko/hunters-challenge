package common;

import phasergame.model.DataTypes.PlayerData;
import sidepanel.model.DataTypes.SidePanelItem;
import sidepanel.PublicAPI.SidePanelStateIncomingDTO;
import phasergame.PublicAPI.GameStateOutcomingDTO;

class SidePanelStateConverter {

    public static function convertGameStateOutcomingDTO(state:GameStateOutcomingDTO):SidePanelStateIncomingDTO {
        var sidePanelitemsList:Array<SidePanelItem> = [];
        for (item in state.playersData) {
            var sidePanelItem:SidePanelItem = {
                label: item.label,
                classImageId: item.classId,
                colorImageId: Std.string(item.teamId),
                progress: getProgress(item)
            }
            sidePanelitemsList.push(sidePanelItem);
        }
        return new SidePanelStateIncomingDTO(sidePanelitemsList);
    }

    private static function getProgress(item:PlayerData):Int {
        var progress:Int = Std.int((item.currentLevel-1)*25 + Std.int(item.expGained)/5);
        return progress <= 100 ? progress : 100;
    }

}
