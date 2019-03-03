package htmlcontrols;

import model.DefaultValues;
class LoginPanelControl {

    public function new(onLogin:Void->Void) {
        updateInputByDefaultValues();
        var button = cast js.Browser.document.getElementById("loginButton");
        button.onclick = function(event) {
            updateDefaultValuesByInput();
            onLogin();
            return false;
        }
    }

    private function updateInputByDefaultValues():Void {
        for (i in 1...7) {
            setById('slot${i}Name', DefaultValues.slots[i-1].name);
            setById('slot${i}Class', DefaultValues.slots[i-1].charType);
            setById('slot${i}Control', DefaultValues.slots[i-1].controlType);
            var spawnXY:String = '${DefaultValues.slots[i-1].x};${DefaultValues.slots[i-1].y}';
            setById('slot${i}Spawn', spawnXY);
        }
        setById('mobsAmount', Std.string(DefaultValues.mobAmount));
        setById('maxLvl', Std.string(DefaultValues.maxLvl));
        setById('baseExp', Std.string(DefaultValues.baseExpGain));
    }

    private function updateDefaultValuesByInput():Void {
        for (i in 1...7) {
            DefaultValues.slots[i-1].name = getById('slot${i}Name');
            DefaultValues.slots[i-1].charType = getById('slot${i}Class');
            DefaultValues.slots[i-1].controlType = getById('slot${i}Control');
            var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(";");
            DefaultValues.slots[i-1].x = Std.parseInt(spawnXY[0]);
            DefaultValues.slots[i-1].y = Std.parseInt(spawnXY[1]);
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