package mainmenu.model;

import mainmenu.model.ConfigTypes.MainMenuConfig;
import mainmenu.model.DataTypes.LobbyItemState;
import mainmenu.model.DataTypes.Page;

class DefaultValues {
    static public var maxMainMenuSize:String = "622";
    static public var screenMode:String = "Fullscreen";

    static private var config:MainMenuConfig;

    static public function setData(data:Dynamic):Void {
        config = data;
        var lobbiesByPageList:Array<Dynamic> = data.lobbiesByPageList;
        config.lobbiesByPage = new Map();
        for(dataObj in lobbiesByPageList) {
            config.lobbiesByPage[dataObj.page] = dataObj.lobby;
        }
    }

    static public function getDefaultPage():Page {
        return config.defaultPageId;
    }

    static public function getLobbyByPage(page:Page):Array<LobbyItemState> {
        return config.lobbiesByPage[page];
    }

    static public var allControlsList:Array<String> = [
        "PLAYER MOUSE",
        "PLAYER ARROWS",
        "PLAYER AWSD",
        "BOT HARD",
        "BOT EASY",
        "NONE"];

    static public var imageClassesIdList:Array<String> = ["SWORDMAN", "BOWMAN", "ELF", "MAGE", "HORSEMAN", "ASSASSIN"];

    static public var showControlList:Array<Array<String>> =
    [[
        allControlsList[0],
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ],[
        allControlsList[1],
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ],[
        allControlsList[2],
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ],[
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ],[
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ],[
        allControlsList[3],
        allControlsList[4],
        allControlsList[5]
    ]];
}