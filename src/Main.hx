import htmlcontrols.store.GameActions;
import htmlcontrols.MainMenu;
import htmlcontrols.sidepanel.SidePanel;
import react.ReactDOM;
import model.DefaultValues;
import htmlcontrols.LoginPanelControl;
import htmlcontrols.SidePanelControl;
import js.html.HtmlElement;
import model.Model;
import phasergame.PhaserGame;
import js.html.CanvasElement;
import react.ReactMacro.jsx;

class Main {

    private var gameCanvas:CanvasElement;
    private var sidePanel:HtmlElement;
    private var loginPanel:HtmlElement;
    private var HTML5game:HtmlElement;

    private var phaserGame:PhaserGame;
    private var sidePanelControl:SidePanelControl;
    private var loginPanelControl:LoginPanelControl;

    static function main() {
        return new Main();
    }

    public function new() {
        DefaultValues.init();
        var data:Dynamic = {slots:DefaultValues.slots, page:GameActions.pagePVP};
        ReactDOM.render(jsx('<$MainMenu data=${data}/>'), js.Browser.document.getElementById('MainMenu'));
        gameCanvas = cast js.Browser.document.getElementById("gameCanvas");
        sidePanel = cast js.Browser.document.getElementById("sidePanel");
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        HTML5game = cast js.Browser.document.getElementById("HTML5game");
        js.Browser.window.addEventListener("resize", onResize);
        onResize();
        sidePanelControl = new SidePanelControl();
        loginPanelControl = new LoginPanelControl(onLogin);
        phaserGame = new PhaserGame();
    }

    private function onResize() {
        var w:Int = js.Browser.window.innerWidth;
        var h:Int = js.Browser.window.innerHeight;

        var multiplayer:Float = ((w / 950) < (h / 654)) ? (w / 950) : (h / 654);

        gameCanvas.style.height = Std.int(654 * multiplayer) + 'px';
        gameCanvas.style.width = Std.int(950 * multiplayer) + 'px';
        gameCanvas.style.position = 'absolute';
        gameCanvas.style.left = (w - 950 * multiplayer) + 'px';
        gameCanvas.style.top = ((h - 654 * multiplayer) / 2) + 'px';
        //todo: use actual padding of sidePanel instead of hardcoded 16*2
        sidePanel.style.width = Std.int(w - 950 * multiplayer - 16*2) + 'px';
    }

    private function onLogin() {
        Model.init();
        ReactDOM.render(jsx('<$SidePanel players=${Model.playersStartConfig}/>'), js.Browser.document.getElementById('sidePanel'));
        gameCanvas.style.display = "block";
        sidePanel.style.display = "block";
        loginPanel.style.display = "none";
        phaserGame.init(gameCanvas, sidePanelControl);
        phaserGame.setCallbackOnGameEnd(onGameEnd);
        if (Model.screenMode == "Fullscreen") {
            HTML5game.requestFullscreen();
        }
    }

    private function onGameEnd() {}
}