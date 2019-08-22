package mainmenu;

import msignal.Signal.Signal0;
import mainmenu.model.DataTypes.Page;
import mainmenu.model.DataTypes.LobbyItemState;
import msignal.Signal.Signal1;

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

class MainMenuSignals
{
    public static var uiCkick:Signal0 = new Signal0();
    public static var startGame:Signal1<MainMenuStateOutcomingDTO> = new Signal1();
}