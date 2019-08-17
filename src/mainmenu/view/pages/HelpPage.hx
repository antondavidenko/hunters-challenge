package mainmenu.view.pages;

import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

class HelpPage extends ReactComponentOfProps<Int> {

    public function new(props:Int):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<div className="helpPage">
        <h3>{common.Localization.get("mainmenu_help_rulesTitle")}</h3>
        {common.Localization.get("mainmenu_help_rulesText")}
        <h3>{common.Localization.get("mainmenu_help_classTitle")}</h3>
        <table><tbody>
        <tr>
        <td><img className="HORSEMAN"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_horseman")}</b> : {common.Localization.get("mainmenu_help_horsemanDescription")}</td>
        <td><img className="BOWMAN"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_bowman")}</b> : {common.Localization.get("mainmenu_help_bowmanDescription")}</td>
        </tr>
        <tr>
        <td><img className="SWORDMAN"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_swordman")}</b> : {common.Localization.get("mainmenu_help_swordmanDescription")}</td>
        <td><img className="MAGE"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_mage")}</b> : {common.Localization.get("mainmenu_help_mageDescription")}</td>
        </tr>
        <tr>
        <td><img className="ELF"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_elf")}</b> : {common.Localization.get("mainmenu_help_elfDescription")}</td>
        <td><img className="ASSASSIN"/></td>
        <td className="helpPageClassDescription"><b>{common.Localization.get("general_assassin")}</b> : {common.Localization.get("mainmenu_help_assassinDescription")}</td>
        </tr>
        </tbody></table>
        </div>');
    }
}