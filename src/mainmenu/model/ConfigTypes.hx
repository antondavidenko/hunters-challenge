package mainmenu.model;

import mainmenu.model.DataTypes.LobbyItemState;
import mainmenu.model.DataTypes.Page;

typedef MainMenuConfig = {
    var lobbiesByPage:Map<Page, Array<LobbyItemState>>;
    var showControlByItems:Array<Array<Int>>;
    var allControlsList:Array<String>;
    var imageClassesIdList:Array<String>;
    var isFullScreenMode:Bool;
    var defaultPageId:Page;
}