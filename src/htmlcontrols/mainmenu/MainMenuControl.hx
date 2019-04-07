package htmlcontrols.mainmenu;

import model.DataTypes.Page;
import htmlcontrols.mainmenu.MainMenu.MainMenuActions;
import model.Model;
import model.MainMenuDefaultValues;

class MainMenuControl {

    private var onLogin:Void -> Void;

    public function new(onLogin:Void -> Void) {
        this.onLogin = onLogin;
        MainMenuActions.startGame.add(startGame);
    }

    private function startGame(page:Page):Void {
        Model.teamMode = page == Page.TEAMS;
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

        MainMenuDefaultValues.mobAmount = Std.parseInt(getById("mobsAmount"));
        MainMenuDefaultValues.baseExpGain = Std.parseFloat(getById("baseExp"));
        MainMenuDefaultValues.screenMode = getById("modeSwitcher");
        MainMenuDefaultValues.showLabel = (getById("labelsSwitcher") == "ON");
    }

    private function setSlot(i:Int):Void {
        var label:String = getById('slot${i}Label');
        var charType:String = getById('slot${i}Class');
        var controlType:String = getById('slot${i}Control');
        var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(",");
        var skin:Int = getById('slot${i}Skin');
        var x:Int = Std.parseInt(spawnXY[0]);
        var y:Int = Std.parseInt(spawnXY[1]);
        MainMenuDefaultValues.slots[i] = new Slot(label, charType, controlType, x, y, "p" + i, skin);
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