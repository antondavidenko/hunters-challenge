package mainmenu.view;

import common.Localization;
import mainmenu.model.DefaultValues;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;
import mainmenu.view.components.ScreenBox;

typedef GameOptionsProps = {
    fullscreen:Bool,
}

class GameOptions extends ReactComponentOfProps<GameOptionsProps> {

    public function new(props:GameOptionsProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr>
            <th className="fifthWidth"><b>{common.Localization.get("mainmenu_options_screenMode")}</b></th>
        </tr>
        <tr>
            <td>
            <ScreenBox selectedValue=${props.fullscreen} boxValue={false} label={common.Localization.get("mainmenu_options_windowed")}/>
            <ScreenBox selectedValue=${props.fullscreen} boxValue={true} label={common.Localization.get("mainmenu_options_fullscreen")}/>
            </td>
        </tr>
        </tbody></table>');
    }

}