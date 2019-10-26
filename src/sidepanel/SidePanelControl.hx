package sidepanel;

import phasergame.api.PhaserGamePort;
import sidepanel.model.DataTypes.SidePanelItem;
import sidepanel.api.SidePanelStateIncomingDTO;
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
        PhaserGamePort.onGameEnd(onEndGame);
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

    public function show():Void {
        sidePanel.style.display = "block";
    }

    private function onEndGame():Void {
        restartButton.style.display = "block";
    }

}