package model;

import model.DataTypes.CharStartConfig;
import model.DataTypes.Page;
import model.DataTypes.GameConfiguration;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerType;

class MainMenuDefaultValues {

    static public var gameConfigurationsData:Map<Page, GameConfiguration> = new Map<Page, GameConfiguration>();
    static public var page:Page = Page.PVE;
    static private var spawnPoints:Array<String> = ["200,300","300,300","400,300","500,300","600,300","700,300"];

    static public function init():Void {
        gameConfigurationsData[Page.PVE] = getPveGameConfiguration();
        gameConfigurationsData[Page.PVP] = getPvpGameConfiguration();
        gameConfigurationsData[Page.TEAMS] = getTeamsGameConfiguration();
        gameConfigurationsData[Page.HELP] = getDefaultGameConfiguration();
    }

    static private function getPvpGameConfiguration():GameConfiguration {
        var slotsPVP:Array<CharStartConfig> = [];
        slotsPVP.push(getCharStartConfig(1, PlayerType.HORSEMAN, ControlType.MOUSE, 2, 1));
        slotsPVP.push(getCharStartConfig(2, PlayerType.BOWMAN, ControlType.ARROWS, 3, 2));
        slotsPVP.push(getCharStartConfig(3, PlayerType.MAGE, ControlType.AWSD, 4, 3));
        var configuration = getDefaultGameConfiguration();
        configuration.slots = slotsPVP;
        configuration.mobAmount = 2;
        return configuration;
    }

    static private function getPveGameConfiguration():GameConfiguration {
        var slotsPVE:Array<CharStartConfig> = [];
        slotsPVE.push(getCharStartConfig(1, PlayerType.HORSEMAN, ControlType.MOUSE, 0, 1));
        slotsPVE.push(getCharStartConfig(2, PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 1, 2));
        slotsPVE.push(getCharStartConfig(3, PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 2, 2));
        slotsPVE.push(getCharStartConfig(4, PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 3, 2));
        slotsPVE.push(getCharStartConfig(5, PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 4, 2));
        slotsPVE.push(getCharStartConfig(6, PlayerType.ELF, ControlType.BOT_HARD, 5, 3));
        var configuration = getDefaultGameConfiguration();
        configuration.slots = slotsPVE;
        configuration.mobAmount = 3;
        return configuration;
    }

    static private function getTeamsGameConfiguration():GameConfiguration {
        var slotsTEAMS:Array<CharStartConfig> = [];
        slotsTEAMS.push(getCharStartConfig(1, PlayerType.HORSEMAN, ControlType.MOUSE, 0, 1));
        slotsTEAMS.push(getCharStartConfig(2, PlayerType.SWORDMAN, ControlType.ARROWS, 1, 1));
        slotsTEAMS.push(getCharStartConfig(3, PlayerType.ELF, ControlType.AWSD, 2, 1));
        slotsTEAMS.push(getCharStartConfig(4, PlayerType.ASSASSIN, ControlType.BOT_HARD, 3, 3));
        slotsTEAMS.push(getCharStartConfig(5, PlayerType.MAGE, ControlType.BOT_HARD, 4, 3));
        slotsTEAMS.push(getCharStartConfig(6, PlayerType.BOWMAN, ControlType.BOT_HARD, 5, 3));
        var configuration = getDefaultGameConfiguration();
        configuration.slots = slotsTEAMS;
        configuration.mobAmount = 3;
        return configuration;
    }

    static public function getDefaultGameConfiguration():GameConfiguration {
        return {
            slots:[],
            screenMode:DefaultValues.screenMode,
            showLabel:DefaultValues.showLabel,
            baseExpGain:DefaultValues.baseExpGain,
            teamMode:false,
            mobAmount:5
        };
    }

    static private function getCharStartConfig(slotNum:Int, charType:String, control:String, spawnPointId:Int, skin:Int):CharStartConfig {
        var prefix = (control!=ControlType.BOT_HARD && control!=ControlType.BOT_SIMPLE)?"Player":"Bot";
        var spawnXY:Array<String> = spawnPoints[spawnPointId].split(",");
        return {
            charType:charType,
            x:Std.parseInt(spawnXY[0]),
            y:Std.parseInt(spawnXY[1]),
            label:'${prefix} ${slotNum}',
            name:'p${slotNum}',
            control:control,
            skin:skin
        };
    }
}