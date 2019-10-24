package common.converters;

import phasergame.api.GameStateOutcomingDTO;
import phasergame.model.DataTypes.PlayerData;
import sidepanel.model.DataTypes.SidePanelItem;
import sidepanel.PublicAPI.SidePanelStateIncomingDTO;

class SidePanelStateConverter {

    private static var labelsMap:Map<String, String> = [
        "team1" => "TEAM RED",
        "team2" => "TEAM GREEN",
        "team3" => "TEAM BLUE",
    ];

    private static var colorsMap:Map<String, String> = [
        "team1" => "1",
        "team2" => "2",
        "team3" => "3",
    ];

    public static function convertGameStateOutcomingDTO(state:GameStateOutcomingDTO):SidePanelStateIncomingDTO {
        var sidePanelitemsList:Array<SidePanelItem> = [];
        for (item in state.playersData) {
            var sidePanelItem:SidePanelItem = {
                label: getLabel(item),
                classImageId: item.classId,
                colorImageId: getColorId(item),
                progress: getProgress(item)
            }
            sidePanelitemsList.push(sidePanelItem);
        }
        return new SidePanelStateIncomingDTO(sidePanelitemsList);
    }

    private static function getColorId(item:PlayerData):String {
        return isTeamMode(item) ? colorsMap[item.label] : Std.string(item.teamId);
    }

    private static function getLabel(item:PlayerData):String {
        return isTeamMode(item) ? labelsMap[item.label] : item.label;
    }

    private static function isTeamMode(item:PlayerData):Bool {
        return item.teamId == -1;
    }

    private static function getProgress(item:PlayerData):Int {
        var progress:Int = Std.int((item.currentLevel - 1) * 25 + Std.int(item.expGained) / 5);
        return progress <= 100 ? progress : 100;
    }

}