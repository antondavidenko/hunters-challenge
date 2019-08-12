package sidepanel;

import phasergame.PublicAPI.PhaserGameSignals;
import js.html.CSSStyleDeclaration;
import phasergame.model.DefaultValues;
import sidepanel.SidePanel;
import phasergame.model.DataTypes.PlayerData;
import phasergame.model.PhaserGameModel;
import js.html.HtmlElement;
import react.ReactMacro.jsx;
import react.ReactDOM;

typedef SidePanelDataFormat = {
    var labels:String;
    var progress:Int;
}

class SidePanelControl {

    var SidePanelData:Array<SidePanelDataFormat> = [];
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
        PhaserGameSignals.gameEnd.add(onEndGame);
        restartButton = cast js.Browser.document.getElementById("restartButton");
    }

    public function updateView():Void {
        for (i in 0...SidePanelData.length) {
            if (elementIsExist('sidePanel_name${i}')) {
                mapDataToHTML('sidePanel_name${i}', SidePanelData[i].labels, i);
                mapProgressToHTML('sidePanel_Player${i}progress', SidePanelData[i].progress+"%");
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

    public function updateData():Void {
        SidePanelData = [];
        for (data in PhaserGameModel.playersData) {
            if (PhaserGameModel.teamMode && data.label.indexOf("team")>=0) {
                SidePanelData.push({ labels : getLabelValueByPlayerData(data), progress : getProgressString(data)});
            } if (!PhaserGameModel.teamMode && data.label.indexOf("team")==-1) {
                SidePanelData.push({ labels : getLabelValueByPlayerData(data), progress : getProgressString(data)});
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

    private function getProgressString(data:PlayerData):Int {
        if (data!= null) {
            var progress:Int = ((data.currentLevel-1)*25) + Std.int(data.expGained/5);
            return progress;
        } else {
            return 0;
        }
    }

    public function sortData():Void {
        SidePanelData.sort(function(a, b) {
            if(a.progress < b.progress) return 1;
            else if(a.progress > b.progress) return -1;
            else return 0;
        });
    }

    public function update():Void {
        updateData();
        sortData();
        updateView();
    }

    public function onResize(windowWidth:Int, windowHeight:Int, multiplayer:Float):Void {
        var computedStyle:CSSStyleDeclaration = js.Browser.window.getComputedStyle(sidePanel);
        var padding:Int = Std.parseInt(computedStyle.padding);
        sidePanel.style.width = Std.int(windowWidth - DefaultValues.getGeneralConfig().phaserGameWidth * multiplayer - padding*2) + 'px';
        sidePanel.style.height = Std.int(DefaultValues.getGeneralConfig().phaserGameHeight * multiplayer) + 'px';
    }

    public function show():Void {
        sidePanel.style.display = "block";
    }

    private function onEndGame():Void {
        restartButton.style.display = "block";
    }
}