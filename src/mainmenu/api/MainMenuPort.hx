package mainmenu.api;

import msignal.Signal.Signal0;
import msignal.Signal.Signal1;

class MainMenuPort {

    private static var uiCkick:Signal0 = new Signal0();
    private static var startGame:Signal1<MainMenuStateOutcomingDTO> = new Signal1();

    private static var mainMenuControl:MainMenuControl;

    static public function executeStart():Void {
        mainMenuControl = new MainMenuControl();
    }

    static public function executeHide():Void {
        mainMenuControl.hide();
    }

    static public function setData(data:Dynamic):Void {
        mainmenu.model.DefaultValues.setData(data);
    }

    static public function doUiCkick():Void {
        uiCkick.dispatch();
    }

    static public function onUiCkick(listener:Void->Void):Void {
        uiCkick.add(listener);
    }

    static public function doStartGame(data:MainMenuStateOutcomingDTO):Void {
        startGame.dispatch(data);
    }

    static public function onStartGame(listener:MainMenuStateOutcomingDTO->Void):Void {
        startGame.add(listener);
    }

}