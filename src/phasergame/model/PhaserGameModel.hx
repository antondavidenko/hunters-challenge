package phasergame.model;

import phasergame.model.DataTypes.ControlType;
import phasergame.model.DataTypes.GameConfiguration;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.DataTypes.MobData;
import phasergame.model.DataTypes.MovingObjectState;

class PhaserGameModel {
    static public var playersStartConfig:Array<MovingObjectState> = [];

    static public var mobAmount:Int;
    static public var maxLvl:Int;
    static public var maxLvlInGame:Int = 1;
    static public var baseExpGain:Float;
    static public var screenMode:String;
    static public var showLabel:Bool;
    static public var leaderPlayerLabel:String;
    static public var teamMode:Bool = false;

    static public var totalMobSlayedCounter = 0;

    static public var playersData:Map<String, PlayerData> = new Map<String, PlayerData>();
    static public var mobsData:Map<String, MobData> = new Map<String, MobData>();
    static public var skinsCollection:Map<String, Int> = new Map<String, Int>();

    static public function init(configuration:Array<Dynamic>):Void {
        maxLvl = DefaultValues.getGameplayConfig().maxLvl;
        mobAmount = MainMenuDefaultValues.getDefaultGameConfiguration().mobAmount;
        baseExpGain = MainMenuDefaultValues.getDefaultGameConfiguration().baseExpGain;
        screenMode = MainMenuDefaultValues.getDefaultGameConfiguration().screenMode;
        showLabel = MainMenuDefaultValues.getDefaultGameConfiguration().showLabel;
        teamMode = MainMenuDefaultValues.getDefaultGameConfiguration().teamMode;

        for (slot in configuration) {
            playersStartConfig.push(dataConverter(slot));
        }
    }

    static private function dataConverter(data:Dynamic):MovingObjectState {
        var classesList:Array<String> = ["swordman", "bowman", "elf", "mage", "horseman", "assassin"];
        var colorsToSkinMap:Map<String, Int> = [ "R" => 1, "G" => 2, "B" => 3];
        var pointStr:String = MainMenuDefaultValues.spawnPoints[Std.int(data.id) - 1];
        var allControls:Array<String> = [ControlType.MOUSE, ControlType.ARROWS, ControlType.AWSD, ControlType.BOT_HARD, ControlType.BOT_SIMPLE, ControlType.NONE];
        var controlsMap:Array<Array<Int>> = [[0,3,4,5],[1,3,4,5],[2,3,4,5],[3,4,5],[3,4,5],[3,4,5]];
        var controlId:Int = controlsMap[Std.int(data.id) - 1][data.controlId];
        return {
            label:"LABEL",
            charType:classesList[Std.int(data.classId)-1],
            control:allControls[controlId],
            x:Std.parseInt(pointStr.split(",")[0]),
            y:Std.parseInt(pointStr.split(",")[1]),
            id:data.id,
            skin: colorsToSkinMap[data.color]
        }
    }
}