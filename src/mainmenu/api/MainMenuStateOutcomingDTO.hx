package mainmenu.api;

import mainmenu.model.DataTypes.Page;
import mainmenu.model.DataTypes.LobbyItemState;
class MainMenuStateOutcomingDTO {

    public var entries:Array<LobbyItemState>;
    public var page:Page;
    public var isFullscreen:Bool;

    public function new (entries:Array<LobbyItemState>, page:Page, isFullscreen:Bool) {
        this.entries = entries;
        this.page = page;
        this.isFullscreen = isFullscreen;
    }

}
