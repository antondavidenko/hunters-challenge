package htmlcontrols.mainmenu;

import model.DefaultValues;
import model.DataTypes.GameConfiguration;
import model.DataTypes.Page;
import model.DataTypes.Slot;
import htmlcontrols.mainmenu.MainMenu.MainMenuActions;
import model.Model;

class MainMenuControl {

    private var onLogin:GameConfiguration -> Void;
    private var configuration:GameConfiguration = DefaultValues.getDefaultGameConfiguration();

    public function new(onLogin:GameConfiguration -> Void) {
        this.onLogin = onLogin;
        MainMenuActions.startGame.add(startGame);
    }

    private function startGame(page:Page):Void {
        Model.teamMode = page == Page.TEAMS;
        updateDefaultValuesByInput();
        onLogin(configuration);
    }

    private function updateDefaultValuesByInput():Void {
        for (i in 0...6) {
            if (elementIsExist(i)) {
                setSlot(i);
            } else {
                break;
            }
        }

        configuration.mobAmount = Std.parseInt(getById("mobsAmount"));
        configuration.baseExpGain = Std.parseFloat(getById("baseExp"));
        configuration.screenMode = getById("modeSwitcher");
        configuration.showLabel = (getById("labelsSwitcher") == "ON");
    }

    private function setSlot(i:Int):Void {
        var label:String = getById('slot${i}Label');
        var charType:String = getById('slot${i}Class');
        var controlType:String = getById('slot${i}Control');
        var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(",");
        var skin:Int = getById('slot${i}Skin');
        var x:Int = Std.parseInt(spawnXY[0]);
        var y:Int = Std.parseInt(spawnXY[1]);
        configuration.slots[i] = new Slot(label, charType, controlType, x, y, "p" + i, skin);
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