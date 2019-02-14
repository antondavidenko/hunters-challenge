package htmlcontrols;

import model.SidePanelModel;
import model.Model;
import js.html.HtmlElement;

class SidePanelControl {

    public function new() {
        update();
    }

    public function updateView():Void {
        mapDataToHTML("sidePanel_name1", SidePanelModel.LABEL1);
        mapDataToHTML("sidePanel_name2", SidePanelModel.LABEL2);
        mapDataToHTML("sidePanel_name3", SidePanelModel.LABEL3);
        mapDataToHTML("sidePanel_name4", SidePanelModel.LABEL4);
        mapDataToHTML("sidePanel_name5", SidePanelModel.LABEL5);

        mapProgressToHTML("sidePanel_Player1progress", getProgressString(Model.playerData.expGained));
        mapProgressToHTML("sidePanel_Player2progress", getProgressString(Model.bot1Data.expGained));
        mapProgressToHTML("sidePanel_Player3progress", getProgressString(Model.bot2Data.expGained));
        mapProgressToHTML("sidePanel_Player4progress", getProgressString(Model.bot3Data.expGained));
        mapProgressToHTML("sidePanel_Player5progress", getProgressString(Model.bot4Data.expGained));
    }

    private function mapDataToHTML(htmlId:String, data:String):Void {
        var nameHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        nameHtml.innerHTML = '<b>${data}</b>';
    }

    private function mapProgressToHTML(htmlId:String, data:String):Void {
        var progressHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        progressHtml.style.width = data;
    }

    private function getProgressString(current:Float):String {
        var total:Int = 100;//Model.totalMobSlayedCounter;
        if (total==0) {
            return "0%";
        } else {
            var result:Float = (current/total)*100;
            return result+"%";
        }
    }

    public function updateData():Void {
        SidePanelModel.LABEL1 = '${Model.startPlayerConfig.label} : mob slayed=${Model.playerData.slayedCounter} lvl: ${Model.playerData.currentLevel}';
        SidePanelModel.LABEL2 = '${Model.startBootsConfig[0].label} : mob slayed=${Model.bot1Data.slayedCounter} lvl: ${Model.bot1Data.currentLevel}';
        SidePanelModel.LABEL3 = '${Model.startBootsConfig[1].label} : mob slayed=${Model.bot2Data.slayedCounter} lvl: ${Model.bot2Data.currentLevel}';
        SidePanelModel.LABEL4 = '${Model.startBootsConfig[2].label} : mob slayed=${Model.bot3Data.slayedCounter} lvl: ${Model.bot3Data.currentLevel}';
        SidePanelModel.LABEL5 = '${Model.startBootsConfig[3].label} : mob slayed=${Model.bot4Data.slayedCounter} lvl: ${Model.bot4Data.currentLevel}';
    }

    public function update():Void {
        updateData();
        updateView();
    }
}
