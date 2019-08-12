package phasergame.model;

import phasergame.model.ConfigTypes.MainMenuConfig;
import phasergame.model.ConfigTypes.SlotConfig;
import phasergame.model.DataTypes.MovingObjectState;
import phasergame.model.DataTypes.Page;
import phasergame.model.DataTypes.GameConfiguration;
import phasergame.model.DataTypes.ControlType;

class MainMenuDefaultValues {

    static public var gameConfigurationsData:Map<Page, GameConfiguration> = new Map<Page, GameConfiguration>();
    static public var page:Page = Page.PVE;
    static public var spawnPoints:Array<String>;
    static private var config:MainMenuConfig;

    static public function init():Void {
        config = DefaultValues.getMainMenuConfig();
        spawnPoints = config.spawnPoints;
        gameConfigurationsData[Page.PVE] = getGameConfiguration(config.pveGameConfiguration);
        gameConfigurationsData[Page.PVP] = getGameConfiguration(config.pvpGameConfiguration);
        gameConfigurationsData[Page.TEAMS] = getGameConfiguration(config.teamsGameConfiguration);
        gameConfigurationsData[Page.HELP] = Reflect.copy(config.defaultGameConfiguration);
    }

    static private function getGameConfiguration(preconfig:Dynamic):GameConfiguration {
        var configuration = Reflect.copy(config.defaultGameConfiguration);
        configuration.mobAmount = Std.parseInt(preconfig.mobAmount);
        return configuration;
    }

    static public function getDefaultGameConfiguration():GameConfiguration {
        return config.defaultGameConfiguration;
    }

    static private function getSlotArray(congigArray:Array<SlotConfig>):Array<MovingObjectState> {
        var slotArray:Array<MovingObjectState> = [];
        for (slotConfig in congigArray) {
            slotArray.push(getCharStartConfig(slotConfig));
        }
        return slotArray;
    }

    static private function getCharStartConfig(config:SlotConfig):MovingObjectState {
        var prefix = (config.control != ControlType.BOT_HARD && config.control != ControlType.BOT_SIMPLE) ? "Player" : "Bot";
        var spawnXY:Array<String> = spawnPoints[Std.parseInt(config.spawnPointId)].split(",");
        return {
            charType:config.charType,
            x:Std.parseInt(spawnXY[0]),
            y:Std.parseInt(spawnXY[1]),
            label:'label',
            id:'p${config.slotNum}',
            control:config.control,
            skin:Std.parseInt(config.skin)
        };
    }
}