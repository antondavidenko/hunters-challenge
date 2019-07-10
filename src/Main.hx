import Utils.Loader;
import sounds.SoundPlayer;
import model.DataTypes.GameConfiguration;
import model.MainMenuDefaultValues;
import htmlcontrols.MainMenuControl;
import htmlcontrols.SidePanelControl;
import js.html.HtmlElement;
import model.PhaserGameModel;
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
        Loader.loadConfig("./config.json", init);
    }

    public function init() {
        MainMenuDefaultValues.init();
        soundPlayer = new SoundPlayer();
        HTML5game = cast js.Browser.document.getElementById("HTML5game");
        js.Browser.window.addEventListener("resize", onResize);
        sidePanelControl = new SidePanelControl();
        mainMenuControl = new MainMenuControl(onLogin);
        phaserGame = new PhaserGame();
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

    private function onLogin(configuration:GameConfiguration) {
        PhaserGameModel.init(configuration);
        sidePanelControl.init();
        sidePanelControl.show();
        mainMenuControl.hide();
        phaserGame.init(sidePanelControl);
        phaserGame.show();
        if (PhaserGameModel.screenMode == "Fullscreen") {
            HTML5game.requestFullscreen();
        }
    }
}