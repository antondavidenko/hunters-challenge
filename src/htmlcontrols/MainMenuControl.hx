package htmlcontrols;

import model.DefaultValues;
import js.html.HtmlElement;
import htmlcontrols.mainmenu.MainMenu;
import model.MainMenuDefaultValues;
import model.DataTypes.GameConfiguration;
import model.DataTypes.Page;
import htmlcontrols.mainmenu.MainMenu.MainMenuActions;
import react.ReactMacro.jsx;
import react.ReactDOM;

class MainMenuControl {

    private var onLogin:GameConfiguration -> Void;
    private var configuration:GameConfiguration;
    private var loginPanel:HtmlElement;

    public function new(onLogin:GameConfiguration -> Void) {
        ReactDOM.render(
            jsx('<$MainMenu data=${MainMenuDefaultValues.gameConfigurationsData} page=${MainMenuDefaultValues.page}/>'),
            js.Browser.document.getElementById('MainMenu')
        );
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        this.onLogin = onLogin;
        MainMenuActions.startGame.add(startGame);
    }

    private function startGame(page:Page):Void {
        configuration.teamMode = page == Page.TEAMS;
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
            skin: Utils.getSkinByColor(getById('slot${i}Skin'))
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

    public function onResize(windowWidth:Int, windowHeight:Int):Void {
        loginPanel.style.marginTop = (windowHeight - DefaultValues.MaxMainMenuSize)/2 + 'px';
    }

    public function hide():Void {
        loginPanel.style.display = "none";
    }
}