package htmlcontrols.mainmenu.helppage;

import model.Localization;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

class HelpPage extends ReactComponentOfProps<Int> {
    public function new(props:Int):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<div className="helpPage">
        <h3>{Localization.get("html_mainMenu_help_rulesTitle")}</h3>
        {Localization.get("html_mainMenu_help_rulesText")}
        <h3>{Localization.get("html_mainMenu_help_classTitle")}</h3>
        <table><tbody>
        <tr>
        <td><img className="HORSEMAN"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_horseman")}</b> : {Localization.get("html_mainMenu_help_horsemanDescription")}</td>
        <td><img className="BOWMAN"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_bowman")}</b> : {Localization.get("html_mainMenu_help_bowmanDescription")}</td>
        </tr>
        <tr>
        <td><img className="SWORDMAN"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_swordman")}</b> : {Localization.get("html_mainMenu_help_swordmanDescription")}</td>
        <td><img className="MAGE"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_mage")}</b> : {Localization.get("html_mainMenu_help_mageDescription")}</td>
        </tr>
        <tr>
        <td><img className="ELF"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_elf")}</b> : {Localization.get("html_mainMenu_help_elfDescription")}</td>
        <td><img className="ASSASSIN"/></td>
        <td className="helpPageClassDescription"><b>{Localization.get("general_assassin")}</b> : {Localization.get("html_mainMenu_help_assassinDescription")}</td>
        </tr>
        </tbody></table>
        </div>');
    }
}