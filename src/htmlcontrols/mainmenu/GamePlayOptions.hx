package htmlcontrols.mainmenu;

import model.DefaultValues;
import model.Localization;
import model.DataTypes.Page;
import model.DataTypes.GameConfiguration;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;
import htmlcontrols.mainmenu.lobby.SelectInput;

typedef GamePlayOptionsProps = {
    var data:Map<Page, GameConfiguration>;
    var page:Page;
}

class GamePlayOptions extends ReactComponentOfProps<GamePlayOptionsProps> {
    public function new(props:GamePlayOptionsProps):Void
    {
        super(props);
        state = {mobAmount:props.data[props.page].mobAmount, page:props.page};
    }

    public override function render():ReactElement
    {
        if (state.page != props.page) {
            state = {mobAmount:props.data[props.page].mobAmount, page:props.page};
        }
        return jsx('<table><tbody>
        <tr>
            <th className="fifthWidth"><b>{Localization.get("html_mainMenu_options_screenMode")}</b></th>
        </tr>
        <tr>
            <td>
            <input id="mobsAmount" type="hidden" placeholder="Enter mobs amount" value="${state.mobAmount}" className="fifthWidth"/>
            <input id="baseExp" type="hidden" placeholder="Base exp gain" defaultValue="25" className="fifthWidth"/>
            <input id="labelsSwitcher" type="hidden" defaultValue="ON"/>
            <SelectInput className="fifthWidth" defaultValue="${this.getDefaultScreenOption()}" id="modeSwitcher" options=${this.getScreenOptions()}/>
            </td>
        </tr>
        </tbody></table>');
    }

    function getScreenOptions():Array<String> { return [
        Localization.get("html_mainMenu_options_fullscreen"),
        Localization.get("html_mainMenu_options_windowed")];
    }

    function getDefaultScreenOption():String {
        var screenMode:String = DefaultValues.getMainMenuConfig().defaultGameConfiguration.screenMode;
        return (screenMode == "Fullscreen")?"Fullscreen":"Windowed";
    }
}