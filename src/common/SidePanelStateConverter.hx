package common;

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
                progress: Std.int(item.expGained)
            }
            sidePanelitemsList.push(sidePanelItem);
        }
        return new SidePanelStateIncomingDTO(sidePanelitemsList);
    }

}
