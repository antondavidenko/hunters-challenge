package sidepanel;

import sidepanel.model.DataTypes.SidePanelItem;
import sidepanel.PublicAPI.SidePanelStateIncomingDTO;
import phasergame.PublicAPI.PhaserGameSignals;
import js.html.CSSStyleDeclaration;
import sidepanel.view.SidePanel;
import js.html.HtmlElement;
import react.ReactMacro.jsx;
import react.ReactDOM;

class SidePanelControl {

    var SidePanelData:Array<SidePanelItem> = [];
    private var sidePanel:HtmlElement;
    private var restartButton:HtmlElement;

    public function new() {
        sidePanel = cast js.Browser.document.getElementById("sidePanel");
    }

    public function init():Void {
        render();
        PhaserGameSignals.gameEnd.add(onEndGame);
        restartButton = cast js.Browser.document.getElementById("restartButton");
    }

    private function render():Void {
        ReactDOM.render(
            jsx('<$SidePanel itemsList=${SidePanelData}/>'),
            js.Browser.document.getElementById('sidePanel')
        );
    }

    public function updateView(state:SidePanelStateIncomingDTO):Void {
        SidePanelData = state.items;
        sortData();
        render();
    }

    public function sortData():Void {
        SidePanelData.sort(function(a, b) {
            if (a.progress < b.progress) return 1;
            else if (a.progress > b.progress) return -1;
            else return 0;
        });
    }

    public function onResize(windowWidth:Int, windowHeight:Int, multiplayer:Float):Void {
//        var computedStyle:CSSStyleDeclaration = js.Browser.window.getComputedStyle(sidePanel);
//        var padding:Int = Std.parseInt(computedStyle.padding);
//        sidePanel.style.width = Std.int(windowWidth - DefaultValues.getGeneralConfig().phaserGameWidth * multiplayer - padding*2) + 'px';
//        sidePanel.style.height = Std.int(DefaultValues.getGeneralConfig().phaserGameHeight * multiplayer) + 'px';
    }

    public function show():Void {
        sidePanel.style.display = "block";
    }

    private function onEndGame():Void {
        restartButton.style.display = "block";
    }
}