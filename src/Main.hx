import htmlcontrols.LoginPanelControl;
import htmlcontrols.SidePanelControl;
import js.html.HtmlElement;
import model.Model;
import phasergame.PhaserGame;
import js.html.CanvasElement;

class Main {

    private var gameCanvas:CanvasElement;
    private var sidePanel:HtmlElement;
    private var loginPanel:HtmlElement;

    private var phaserGame:PhaserGame;
    private var sidePanelControl:SidePanelControl;
    private var loginPanelControl:LoginPanelControl;

    static function main() {
        return new Main();
    }

    public function new() {
        gameCanvas = cast js.Browser.document.getElementById("gameCanvas");
        sidePanel = cast js.Browser.document.getElementById("sidePanel");
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        js.Browser.window.addEventListener("resize", onResize);
        onResize();
        Model.init();
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
        trace("onLogin");
        gameCanvas.style.display = "block";
        sidePanel.style.display = "block";
        loginPanel.style.display = "none";
        phaserGame.init(gameCanvas, sidePanelControl);
    }
}