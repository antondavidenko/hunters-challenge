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

        mapProgressToHTML("sidePanel_Player1progress", getProgressString(Model.playerMobSlayedCounter));
        mapProgressToHTML("sidePanel_Player2progress", getProgressString(Model.bot1MobSlayedCounter));
        mapProgressToHTML("sidePanel_Player3progress", getProgressString(Model.bot2MobSlayedCounter));
        mapProgressToHTML("sidePanel_Player4progress", getProgressString(Model.bot3MobSlayedCounter));
        mapProgressToHTML("sidePanel_Player5progress", getProgressString(Model.bot4MobSlayedCounter));
    }

    private function mapDataToHTML(htmlId:String, data:String):Void {
        var nameHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        nameHtml.innerHTML = '<b>${data}</b>';
    }

    private function mapProgressToHTML(htmlId:String, data:String):Void {
        var progressHtml:HtmlElement = cast js.Browser.document.getElementById(htmlId);
        progressHtml.style.width = data;
    }

    private function getProgressString(current:Int):String {
        var total:Int = Model.totalMobSlayedCounter;
        if (total==0) {
            return "0%";
        } else {
            var result:Float = (current/total)*100;
            return result+"%";
        }
    }

    public function updateData():Void {
        SidePanelModel.LABEL1 = '${Model.startPlayerConfig.label} : mob slayed=${Model.playerMobSlayedCounter}';
        SidePanelModel.LABEL2 = '${Model.startBootsConfig[0].label} : mob slayed=${Model.bot1MobSlayedCounter}';
        SidePanelModel.LABEL3 = '${Model.startBootsConfig[1].label} : mob slayed=${Model.bot2MobSlayedCounter}';
        SidePanelModel.LABEL4 = '${Model.startBootsConfig[2].label} : mob slayed=${Model.bot3MobSlayedCounter}';
        SidePanelModel.LABEL5 = '${Model.startBootsConfig[3].label} : mob slayed=${Model.bot4MobSlayedCounter}';
    }

    public function update():Void {
        updateData();
        updateView();
    }
}
