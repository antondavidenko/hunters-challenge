package htmlcontrols;

import model.DefaultValues;
class LoginPanelControl {

    public function new(onLogin:Void->Void) {
        var button = cast js.Browser.document.getElementById("loginButton");
        button.onclick = function(event) {
            updateDefaultValuesByInput();
            onLogin();
            return false;
        }
    }

    private function updateDefaultValuesByInput():Void {
        for (i in 0...6) {
            DefaultValues.slots[i].label = getById('slot${i}Label');
            DefaultValues.slots[i].charType = getById('slot${i}Class');
            DefaultValues.slots[i].controlType = getById('slot${i}Control');
            var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(",");
            DefaultValues.slots[i].x = Std.parseInt(spawnXY[0]);
            DefaultValues.slots[i].y = Std.parseInt(spawnXY[1]);
        }

        DefaultValues.mobAmount = Std.parseInt(getById("mobsAmount"));
        DefaultValues.baseExpGain = Std.parseFloat(getById("baseExp"));
        DefaultValues.maxLvl = Std.parseInt(getById("maxLvl"));
        DefaultValues.screenMode = getById("modeSwitcher");
        DefaultValues.showLabel = (getById("labelsSwitcher")=="ON");
    }

    private function getById(id:String):Dynamic {
        var htmlData:Dynamic;
        htmlData = js.Browser.document.getElementById(id);
        return htmlData.value;
    }

    private function setById(id:String, value:String):Void {
        var htmlData:Dynamic;
        htmlData = js.Browser.document.getElementById(id);
        htmlData.value = value;
    }
}