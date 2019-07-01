package model;

import model.ConfigTypes.MainMenuConfig;
import model.ConfigTypes.SlotConfig;
import model.DataTypes.MovingObjectState;
import model.DataTypes.Page;
import model.DataTypes.GameConfiguration;
import model.DataTypes.ControlType;

class MainMenuDefaultValues {

    static public var gameConfigurationsData:Map<Page, GameConfiguration> = new Map<Page, GameConfiguration>();
    static public var page:Page = Page.PVE;
    static private var spawnPoints:Array<String>;
    static private var config:MainMenuConfig;

    static public function init():Void {
        config = Utils.getDataStorage().configsList.MainMenu;
        spawnPoints = config.spawnPoints;
        gameConfigurationsData[Page.PVE] = getPveGameConfiguration();
        gameConfigurationsData[Page.PVP] = getPvpGameConfiguration();
        gameConfigurationsData[Page.TEAMS] = getTeamsGameConfiguration();
        gameConfigurationsData[Page.HELP] = Reflect.copy(config.defaultGameConfiguration);
    }

    static private function getPvpGameConfiguration():GameConfiguration {
        var configuration = Reflect.copy(config.defaultGameConfiguration);
        configuration.slots = getSlotArray(config.lobbyPvpSlots);
        configuration.mobAmount = 2;
        return configuration;
    }

    static private function getPveGameConfiguration():GameConfiguration {
        var configuration = Reflect.copy(config.defaultGameConfiguration);
        configuration.slots = getSlotArray(config.lobbyPveSlots);
        configuration.mobAmount = 3;
        return configuration;
    }

    static private function getTeamsGameConfiguration():GameConfiguration {
        var configuration = Reflect.copy(config.defaultGameConfiguration);
        configuration.slots = getSlotArray(config.lobbyTeamsSlots);
        configuration.mobAmount = 3;
        return configuration;
    }

    static private function getSlotArray(congigArray:Array<SlotConfig>):Array<MovingObjectState> {
        var slotArray:Array<MovingObjectState> = [];
        for (slotConfig in congigArray) {
            slotArray.push(getCharStartConfig(slotConfig));
        }
        return slotArray;
    }

    static private function getCharStartConfig(config:SlotConfig):MovingObjectState {
        var prefix = (config.control!=ControlType.BOT_HARD && config.control!=ControlType.BOT_SIMPLE)?"Player":"Bot";
        var spawnXY:Array<String> = spawnPoints[Std.parseInt(config.spawnPointId)].split(",");
        return {
            charType:config.charType,
            x:Std.parseInt(spawnXY[0]),
            y:Std.parseInt(spawnXY[1]),
            label:'${prefix} ${config.slotNum}',
            name:'p${config.slotNum}',
            control:config.control,
            skin:Std.parseInt(config.skin)
        };
    }
}