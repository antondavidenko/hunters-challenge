import common.GameConfigurationConverter;
import phasergame.model.PhaserGameModel;
import mainmenu.PublicAPI.MainMenuStateOutcomingDTO;
import mainmenu.PublicAPI.MainMenuSignals;
import mainmenu.MainMenuControl;
import common.Loader;
import sounds.SoundPlayer;
import sidepanel.SidePanelControl;
import js.html.HtmlElement;
import phasergame.PhaserGame;

class Main {

    private var HTML5game:HtmlElement;
    private var phaserGame:PhaserGame;
    private var sidePanelControl:SidePanelControl;
    private var mainMenuControl:MainMenuControl;
    private var soundPlayer:SoundPlayer;

    static function main() {
        return new Main();
    }

    public function new() {
        Loader.loadAll(init);
    }

    public function init() {
        soundPlayer = new SoundPlayer();
        HTML5game = cast js.Browser.document.getElementById("HTML5game");
        js.Browser.window.addEventListener("resize", onResize);
        sidePanelControl = new SidePanelControl();
        mainMenuControl = new MainMenuControl();
        phaserGame = new PhaserGame();
        MainMenuSignals.startGame.add(onLogin);
        onResize();
    }

    private function onResize() {
        var windowWidth:Int = js.Browser.window.innerWidth;
        var windowHeight:Int = js.Browser.window.innerHeight;
        var multiplayer:Float = ((windowWidth / 950) < (windowHeight / 654)) ? (windowWidth / 950) : (windowHeight / 654);

        phaserGame.onResize(windowWidth, windowHeight, multiplayer);
        sidePanelControl.onResize(windowWidth, windowHeight, multiplayer);
        mainMenuControl.onResize(windowWidth, windowHeight);
    }

    private function onLogin(configuration:MainMenuStateOutcomingDTO) {
        PhaserGameModel.init(GameConfigurationConverter.convertMainMenuExportState(configuration));
        sidePanelControl.init();
        sidePanelControl.show();
        mainMenuControl.hide();
        phaserGame.init(sidePanelControl);
        phaserGame.show();
        if (PhaserGameModel.isFullscreen) {
            HTML5game.requestFullscreen();
        }
    }
}