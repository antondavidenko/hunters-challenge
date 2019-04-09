package model;

import model.DataTypes.Page;
import model.DataTypes.GameConfiguration;
import model.DataTypes.Slot;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerType;

class MainMenuDefaultValues {

    static public var gameConfigurationsData:Map<Page, GameConfiguration> = new Map<Page, GameConfiguration>();
    static public var page:Page = Page.PVE;

    static public function init():Void {
        gameConfigurationsData[Page.PVE] = getPveGameConfiguration();
        gameConfigurationsData[Page.PVP] = getPvpGameConfiguration();
        gameConfigurationsData[Page.TEAMS] = getTeamsGameConfiguration();
        gameConfigurationsData[Page.HELP] = DefaultValues.getDefaultGameConfiguration();
    }

    static private function getPvpGameConfiguration():GameConfiguration {
        var slotsPVP:Array<Slot> = [];
        slotsPVP.push(new Slot("Player 1", PlayerType.HORSEMAN, ControlType.MOUSE, 400, 300, "p1", 1));
        slotsPVP.push(new Slot("Player 2", PlayerType.BOWMAN, ControlType.ARROWS, 500, 300, "p2", 2));
        slotsPVP.push(new Slot("Player 3", PlayerType.MAGE, ControlType.AWSD, 600, 300, "p3", 3));
        var configuration = DefaultValues.getDefaultGameConfiguration();
        configuration.slots = slotsPVP;
        configuration.mobAmount = 2;
        return configuration;
    }

    static private function getPveGameConfiguration():GameConfiguration {
        var slotsPVE:Array<Slot> = [];
        slotsPVE.push(new Slot("Player 1", PlayerType.HORSEMAN, ControlType.MOUSE, 400, 300, "p1", 1));
        slotsPVE.push(new Slot("bot 1", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 200, 300, "p2", 2));
        slotsPVE.push(new Slot("bot 2", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 300, 300, "p3", 2));
        slotsPVE.push(new Slot("bot 3", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 500, 300, "p4", 2));
        slotsPVE.push(new Slot("bot 4", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 600, 300, "p5", 2));
        slotsPVE.push(new Slot("bot 5", PlayerType.ELF, ControlType.BOT_HARD, 700, 300, "p6", 3));
        var configuration = DefaultValues.getDefaultGameConfiguration();
        configuration.slots = slotsPVE;
        configuration.mobAmount = 3;
        return configuration;
    }

    static private function getTeamsGameConfiguration():GameConfiguration {
        var slotsTEAMS:Array<Slot> = [];
        slotsTEAMS.push(new Slot("Player 1", PlayerType.HORSEMAN, ControlType.MOUSE, 400, 300, "p1", 1));
        slotsTEAMS.push(new Slot("Player 2", PlayerType.SWORDMAN, ControlType.ARROWS, 200, 300, "p2", 1));
        slotsTEAMS.push(new Slot("Player 3", PlayerType.ELF, ControlType.AWSD, 300, 300, "p3", 1));
        slotsTEAMS.push(new Slot("bot 1", PlayerType.SWORDMAN, ControlType.BOT_HARD, 500, 300, "p4", 3));
        slotsTEAMS.push(new Slot("bot 2", PlayerType.MAGE, ControlType.BOT_HARD, 600, 300, "p5", 3));
        slotsTEAMS.push(new Slot("bot 3", PlayerType.HORSEMAN, ControlType.BOT_HARD, 700, 300, "p6", 3));
        var configuration = DefaultValues.getDefaultGameConfiguration();
        configuration.slots = slotsTEAMS;
        configuration.mobAmount = 3;
        return configuration;
    }
}