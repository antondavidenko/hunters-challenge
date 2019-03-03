package htmlcontrols;

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

        mapProgressToHTML("sidePanel_Player1progress", getProgressString(Model.charsData[0].expGained));
        mapProgressToHTML("sidePanel_Player2progress", getProgressString(Model.charsData[1].expGained));
        mapProgressToHTML("sidePanel_Player3progress", getProgressString(Model.charsData[2].expGained));
        mapProgressToHTML("sidePanel_Player4progress", getProgressString(Model.charsData[3].expGained));
        mapProgressToHTML("sidePanel_Player5progress", getProgressString(Model.charsData[4].expGained));
        mapProgressToHTML("sidePanel_Player6progress", getProgressString(Model.charsData[5].expGained));
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
        SidePanelModel.LABEL1 = '${Model.charsStartConfig[0].label} : mob slayed=${Model.charsData[0].slayedCounter} lvl: ${Model.charsData[0].currentLevel}';
        SidePanelModel.LABEL2 = '${Model.charsStartConfig[1].label} : mob slayed=${Model.charsData[1].slayedCounter} lvl: ${Model.charsData[1].currentLevel}';
        SidePanelModel.LABEL3 = '${Model.charsStartConfig[2].label} : mob slayed=${Model.charsData[2].slayedCounter} lvl: ${Model.charsData[2].currentLevel}';
        SidePanelModel.LABEL4 = '${Model.charsStartConfig[3].label} : mob slayed=${Model.charsData[3].slayedCounter} lvl: ${Model.charsData[3].currentLevel}';
        SidePanelModel.LABEL5 = '${Model.charsStartConfig[4].label} : mob slayed=${Model.charsData[4].slayedCounter} lvl: ${Model.charsData[4].currentLevel}';
        SidePanelModel.LABEL6 = '${Model.charsStartConfig[5].label} : mob slayed=${Model.charsData[5].slayedCounter} lvl: ${Model.charsData[5].currentLevel}';
    }

    public function update():Void {
        updateData();
        updateView();
    }
}