package htmlcontrols;

import model.PhaserGameModel.PlayerData;
import model.Model;
import js.html.HtmlElement;

class SidePanelControl {

    var SidePanelLabels:Array<String> = [];

    public function new(){}

    public function updateView():Void {
        for (i in 1...7) {
            mapDataToHTML('sidePanel_name${i}', SidePanelLabels[i]);
            mapProgressToHTML('sidePanel_Player${i}progress', getProgressString(Model.playersData['p${i}']));
        }
    }

    private function mapDataToHTML(htmlId:String, data:String):Void {
        var nameHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        nameHtml.innerHTML = '<b>${data}</b>';
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
        for (i in 1...7) {
            SidePanelLabels[i] = getLabelValueByPlayerData(Model.playersData['p${i}']);
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
}