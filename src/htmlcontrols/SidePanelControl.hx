package htmlcontrols;

import phasergame.PhaserGame.PhaserGameActions;
import model.DefaultValues;
import htmlcontrols.sidepanel.SidePanel;
import model.DataTypes.PlayerData;
import model.PhaserGameModel;
import js.html.HtmlElement;
import react.ReactMacro.jsx;
import react.ReactDOM;

class SidePanelControl {

    var SidePanelLabels:Array<String> = [];
    var SidePanelProgress:Array<String> = [];
    private var sidePanel:HtmlElement;
    private var restartButton:HtmlElement;

    public function new() {
        sidePanel = cast js.Browser.document.getElementById("sidePanel");
    }

    public function init() {
        ReactDOM.render(
            jsx('<$SidePanel players=${PhaserGameModel.playersStartConfig}/>'),
            js.Browser.document.getElementById('sidePanel')
        );
        PhaserGameActions.gameEnd.add(onEndGame);
        restartButton = cast js.Browser.document.getElementById("restartButton");
    }

    public function updateView():Void {
        for (i in 0...6) {
            if (elementIsExist('sidePanel_name${i}')) {
                mapDataToHTML('sidePanel_name${i}', SidePanelLabels[i], i);
                mapProgressToHTML('sidePanel_Player${i}progress', SidePanelProgress[i]);
            } else {
                break;
            }
        }
    }

    private function elementIsExist(htmlId:String):Bool {
        return cast js.Browser.document.getElementById(htmlId) != null;
    }

    private function mapDataToHTML(htmlId:String, data:String, id:Int):Void {
        var nameHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        nameHtml.innerHTML = '<b>${data}</b>';
        if (data == "") {
            var panelHtml:HtmlElement = cast js.Browser.document.getElementById("sidePanel_playerPanelId"+id);
            panelHtml.style.display = "none";
        }
    }

    private function mapProgressToHTML(htmlId:String, data:String):Void {
        var progressHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        progressHtml.style.width = data;
    }

    private function getProgressString(data:PlayerData):String {
        if (data!= null) {
            return data.expGained+"%";
        } else {
            return "0%";
        }
    }

    public function updateData():Void {
        for (i in 0...6) {
            if (PhaserGameModel.teamMode) {
                SidePanelLabels[i] = getLabelValueByPlayerData(PhaserGameModel.playersData['team${i}']);
                SidePanelProgress[i] = getProgressString(PhaserGameModel.playersData['team${i}']);
            } else {
                SidePanelLabels[i] = getLabelValueByPlayerData(PhaserGameModel.playersData['p${i}']);
                SidePanelProgress[i] = getProgressString(PhaserGameModel.playersData['p${i}']);
            }
        }
    }

    private function getLabelValueByPlayerData(data:PlayerData):String {
        if (data!= null) {
            return '${data.label} : mob slayed=${data.slayedCounter} lvl: ${data.currentLevel}';
        } else {
            return "";
        }
    }

    public function update():Void {
        updateData();
        updateView();
    }

    public function onResize(windowWidth:Int, windowHeight:Int, multiplayer:Float):Void {
        //todo: use actual padding of sidePanel instead of hardcoded 16*2
        sidePanel.style.width = Std.int(windowWidth - DefaultValues.phaserGameWidth * multiplayer - 16*2) + 'px';
        sidePanel.style.height = Std.int(DefaultValues.phaserGameHeight * multiplayer) + 'px';
    }

    public function show():Void {
        sidePanel.style.display = "block";
    }

    private function onEndGame():Void {
        restartButton.style.display = "block";
    }
}