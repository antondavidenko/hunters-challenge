package htmlcontrols;

import model.PhaserGameModel.CharType;
import model.Model;
class LoginPanelControl {

    public function new(onLogin:Void->Void) {
        var button = cast js.Browser.document.getElementById("loginButton");
        button.onclick = function(event) {
            var htmlData:Dynamic;
            htmlData = js.Browser.document.getElementById("playerName");
            Model.startPlayerConfig.label = htmlData.value;

            htmlData = js.Browser.document.getElementById("playerClass");
            Model.startPlayerConfig.charType = getTypeByHtmlData(htmlData.value);

            htmlData = js.Browser.document.getElementById("bot1Class");
            Model.startBootsConfig[0].charType = getTypeByHtmlData(htmlData.value);

            htmlData = js.Browser.document.getElementById("bot2Class");
            Model.startBootsConfig[1].charType = getTypeByHtmlData(htmlData.value);

            htmlData = js.Browser.document.getElementById("bot3Class");
            Model.startBootsConfig[2].charType = getTypeByHtmlData(htmlData.value);

            htmlData = js.Browser.document.getElementById("bot4Class");
            Model.startBootsConfig[3].charType = getTypeByHtmlData(htmlData.value);

            htmlData = js.Browser.document.getElementById("mobsAmount");
            Model.mobAmount = Std.parseInt(htmlData.value);

            onLogin();
            return false;
        }
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
