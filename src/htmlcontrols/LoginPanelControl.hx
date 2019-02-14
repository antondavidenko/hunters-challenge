package htmlcontrols;

import model.PhaserGameModel.CharType;
import model.Model;
class LoginPanelControl {

    public function new(onLogin:Void->Void) {
        var button = cast js.Browser.document.getElementById("loginButton");
        button.onclick = function(event) {

            Model.startPlayerConfig.label = getById("playerName");
            Model.startBootsConfig[0].label = getById("bot1Name");
            Model.startBootsConfig[1].label = getById("bot2Name");
            Model.startBootsConfig[2].label = getById("bot3Name");
            Model.startBootsConfig[3].label = getById("bot4Name");

            Model.startPlayerConfig.charType = getTypeByHtmlData(getById("playerClass"));
            Model.startBootsConfig[0].charType = getTypeByHtmlData(getById("bot1Class"));
            Model.startBootsConfig[1].charType = getTypeByHtmlData(getById("bot2Class"));
            Model.startBootsConfig[2].charType = getTypeByHtmlData(getById("bot3Class"));
            Model.startBootsConfig[3].charType = getTypeByHtmlData(getById("bot4Class"));

            Model.mobAmount = Std.parseInt(getById("mobsAmount"));
            Model.baseExpGain = Std.parseFloat(getById("baseExp"));
            Model.maxLvl = Std.parseInt(getById("maxLvl"));
            Model.screenMode = getById("modeSwitcher");
            Model.showLabel = (getById("labelsSwitcher")=="ON");

            onLogin();
            return false;
        }
    }

    private function getById(id:String):Dynamic {
        var htmlData:Dynamic;
        htmlData = js.Browser.document.getElementById(id);
        return htmlData.value;
    }

    private function getTypeByHtmlData(data:String):String {
        var result:String = CharType.SWORDMAN;
        switch data {
            case "horseman": result = CharType.HORSEMAN;
            case "mage": result = CharType.MAGE;
            case "elf": result = CharType.ELF;
            case "bowman": result = CharType.BOWMAN;
        }
        return result;
    }
}