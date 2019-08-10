package mainmenu.view;

import redux.react.IConnectedComponent;
import haxe.web.Dispatch;
import mainmenu.action.LobbyAction;
import mainmenu.model.DataTypes.Page;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef GameModesProps = {
    page: Page,
}

class GameModes extends ReactComponentOfProps<GameModesProps> implements IConnectedComponent {
    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr><td>{showSwitcher("Local PVP", Page.PVP, onPVPClicked)}</td></tr>
        <tr><td>{showSwitcher("Player vs bots", Page.PVE, onPVEClicked)}</td></tr>
        <tr><td>{showSwitcher("TEAMS vs", Page.TEAMS, onTeamsClicked)}</td></tr>
        <tr><td>{showSwitcher("HELP", Page.HELP, onHelpClicked)}</td></tr>
        </tbody></table>');
    }

    function showSwitcher(pageName:String, page:Page, pageOnClick:js.html.Event->Void):ReactElement
    {
        if (props.page != page) {
            return jsx('<button className="modeButton" onClick="${pageOnClick}">${pageName}</button>');
        } else {
            return jsx('<div className="modeButtonActive">${pageName}</div>');
        }
    }

    function onPVPClicked(evt:js.html.Event):Void {
        dispatch(LobbyAction.SetPage(Page.PVP));
    }
    function onPVEClicked(evt:js.html.Event):Void {
        dispatch(LobbyAction.SetPage(Page.PVE));
    }
    function onTeamsClicked(evt:js.html.Event):Void {
        dispatch(LobbyAction.SetPage(Page.TEAMS));
    }
    function onHelpClicked(evt:js.html.Event):Void {
        dispatch(LobbyAction.SetPage(Page.HELP));
    }
}