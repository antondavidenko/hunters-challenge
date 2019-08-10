package mainmenu.view;

import phasergame.model.Localization;
import mainmenu.model.DefaultValues;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;
import mainmenu.view.components.SelectInput;

class GameOptions extends ReactComponentOfProps<Int> {
    public function new(props:Int):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr>
            <th className="fifthWidth"><b>{Localization.get("mainmenu_options_screenMode")}</b></th>
        </tr>
        <tr>
            <td>
            <SelectInput className="fifthWidth" defaultValue="${this.getDefaultScreenOption()}" id="modeSwitcher" options=${this.getScreenOptions()}/>
            </td>
        </tr>
        </tbody></table>');
    }

    function getScreenOptions():Array<String> { return [
        Localization.get("mainmenu_options_fullscreen"),
        Localization.get("mainmenu_options_windowed")];
    }

    function getDefaultScreenOption():String {
        var screenMode:String = DefaultValues.screenMode;
        return (screenMode == "Fullscreen")?"Fullscreen":"Windowed";
    }
}