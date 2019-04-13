package htmlcontrols.mainmenu;

import model.MainMenuDefaultValues;
import model.DataTypes.GameConfiguration;
import model.DataTypes.Page;
import htmlcontrols.mainmenu.MainMenu.MainMenuActions;
import model.Model;

class MainMenuControl {

    private var onLogin:GameConfiguration -> Void;
    private var configuration:GameConfiguration = MainMenuDefaultValues.getDefaultGameConfiguration();

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
        var spawnXY:Array<String> = Std.string(getById('slot${i}Spawn')).split(",");
        configuration.slots[i] = {
            label: getById('slot${i}Label'),
            charType: getById('slot${i}Class'),
            control: getById('slot${i}Control'),
            x: Std.parseInt(spawnXY[0]),
            y: Std.parseInt(spawnXY[1]),
            name: "p" + i,
            skin: getById('slot${i}Skin')
        };
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