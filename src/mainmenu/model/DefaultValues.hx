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
        if (config.lobbiesByPage.exists(page)) {
            return config.lobbiesByPage[page];
        } else {
            return [];
        }
    }

    static public function getImageClassesById(id:Int):String {
        return config.imageClassesIdList[id];
    }

    static public function getImageClassesLength():Int {
        return config.imageClassesIdList.length;
    }

    static public function getControlListById(id:Int):Array<Int> {
        return config.showControlByItems[id];
    }

    static public function getControlLabelById(id:Int):String {
        return Localization.get(config.allControlsList[id]);
    }

    static public function getFullscreen():Bool {
        return config.isFullScreenMode;
    }
}