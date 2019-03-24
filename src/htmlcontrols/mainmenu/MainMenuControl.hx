package htmlcontrols.mainmenu;

import htmlcontrols.store.GameActions;
import model.DefaultValues;
class MainMenuControl {

    private var onLogin:Void->Void;

    public function new(onLogin:Void->Void) {
        this.onLogin = onLogin;
        GameActions.startGame.add(startGame);
    }

    private function startGame(page:String):Void
    {
        updateDefaultValuesByInput();
        onLogin();
    }

    private function updateDefaultValuesByInput():Void {
        for (i in 0...6) {
            if (elementIsExist(i)) {
                setSlot(i);
            } else {
                break;
            }
        }

        DefaultValues.mobAmount = Std.parseInt(getById("mobsAmount"));
        DefaultValues.baseExpGain = Std.parseFloat(getById("baseExp"));
        DefaultValues.screenMode = getById("modeSwitcher");
        DefaultValues.showLabel = (getById("labelsSwitcher")=="ON");
    }

    private function setSlot(i:Int):Void {
        var label:String = getById('slot${i}Label');
        var charType:String = getById('slot${i}Class');
        var controlType:String = getById('slot${i}Control');
        var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(",");
        var x:Int = Std.parseInt(spawnXY[0]);
        var y:Int = Std.parseInt(spawnXY[1]);
        DefaultValues.slots[i] = new Slot(label,charType, controlType, x, y, "p"+i);
    }

    private function elementIsExist(i:Int):Bool {
        return js.Browser.document.getElementById('slot${i}Label') != null;
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