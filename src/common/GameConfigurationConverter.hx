package common;

import phasergame.model.DataTypes.MovingObjectState;
import phasergame.model.DataTypes.ControlType;
import phasergame.model.DefaultValues;
import phasergame.PublicAPI.GameConfigurationIncomingDTO;
import mainmenu.PublicAPI.MainMenuStateOutcomingDTO;

class GameConfigurationConverter {

    public static function convertMainMenuExportState(config:MainMenuStateOutcomingDTO):GameConfigurationIncomingDTO {
        var playersStartConfig:Array<MovingObjectState> = [];
        for (slot in config.entries) {
            playersStartConfig.push(dataConverter(slot));
        }
        return new GameConfigurationIncomingDTO(playersStartConfig, Std.string(config.page), config.isFullscreen);
    }

    static private function dataConverter(data:Dynamic):MovingObjectState {
        var classesList:Array<String> = ["swordman", "bowman", "elf", "mage", "horseman", "assassin"];
        var colorsToSkinMap:Map<String, Int> = [ "R" => 1, "G" => 2, "B" => 3];
        var pointStr:String = DefaultValues.getGameplayConfig().spawnPoints[Std.int(data.id) - 1];
        var allControls:Array<String> = [ControlType.MOUSE, ControlType.ARROWS, ControlType.AWSD, ControlType.BOT_HARD, ControlType.BOT_SIMPLE, ControlType.NONE];
        var ingameLabelsKeys:Array<String> = [
            "ingamelabel_mouse",
            "ingamelabel_keys_arrows",
            "ingamelabel_keys_awsd",
            "ingamelabel_bot_simple",
            "ingamelabel_bot_hard",
        ];
        var controlsMap:Array<Array<Int>> = [[0,3,4,5],[1,3,4,5],[2,3,4,5],[3,4,5],[3,4,5],[3,4,5]];
        var controlId:Int = controlsMap[Std.int(data.id) - 1][data.controlId];
        return {
            label:Localization.get(ingameLabelsKeys[controlId]),
            charType:classesList[Std.int(data.classId)-1],
            control:allControls[controlId],
            x:Std.parseInt(pointStr.split(",")[0]),
            y:Std.parseInt(pointStr.split(",")[1]),
            id:data.id,
            skin: colorsToSkinMap[data.color]
        }
    }

}
