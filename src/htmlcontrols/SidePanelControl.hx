package htmlcontrols;

import model.PhaserGameModel.PlayerData;
import model.SidePanelModel;
import model.Model;
import js.html.HtmlElement;

class SidePanelControl {

    public function new(){}

    public function updateView():Void {
        mapDataToHTML("sidePanel_name1", SidePanelModel.LABEL1);
        mapDataToHTML("sidePanel_name2", SidePanelModel.LABEL2);
        mapDataToHTML("sidePanel_name3", SidePanelModel.LABEL3);
        mapDataToHTML("sidePanel_name4", SidePanelModel.LABEL4);
        mapDataToHTML("sidePanel_name5", SidePanelModel.LABEL5);
        mapDataToHTML("sidePanel_name6", SidePanelModel.LABEL6);

        mapProgressToHTML("sidePanel_Player1progress", getProgressString(Model.playersData["p1"]));
        mapProgressToHTML("sidePanel_Player2progress", getProgressString(Model.playersData["p2"]));
        mapProgressToHTML("sidePanel_Player3progress", getProgressString(Model.playersData["p3"]));
        mapProgressToHTML("sidePanel_Player4progress", getProgressString(Model.playersData["p4"]));
        mapProgressToHTML("sidePanel_Player5progress", getProgressString(Model.playersData["p5"]));
        mapProgressToHTML("sidePanel_Player6progress", getProgressString(Model.playersData["p6"]));
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
        SidePanelModel.LABEL1 = getLabelValueByPlayerData(Model.playersData["p1"]);
        SidePanelModel.LABEL2 = getLabelValueByPlayerData(Model.playersData["p2"]);
        SidePanelModel.LABEL3 = getLabelValueByPlayerData(Model.playersData["p3"]);
        SidePanelModel.LABEL4 = getLabelValueByPlayerData(Model.playersData["p4"]);
        SidePanelModel.LABEL5 = getLabelValueByPlayerData(Model.playersData["p5"]);
        SidePanelModel.LABEL6 = getLabelValueByPlayerData(Model.playersData["p6"]);
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