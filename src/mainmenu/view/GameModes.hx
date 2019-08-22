package mainmenu.view;

import mainmenu.PublicAPI.MainMenuSignals;
import redux.react.IConnectedComponent;
import haxe.web.Dispatch;
import mainmenu.action.MainMenuActions;
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
        return jsx('<div>
        {showSwitcher("Local PVP", Page.PVP, onPVPClicked)}
        {showSwitcher("Player vs bots", Page.PVE, onPVEClicked)}
        {showSwitcher("TEAMS vs", Page.TEAMS, onTeamsClicked)}
        {showSwitcher("HELP", Page.HELP, onHelpClicked)}
        </div>');
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
        MainMenuSignals.uiCkick.dispatch();
        dispatch(MainMenuActions.SetPage(Page.PVP));
    }

    function onPVEClicked(evt:js.html.Event):Void {
        MainMenuSignals.uiCkick.dispatch();
        dispatch(MainMenuActions.SetPage(Page.PVE));
    }

    function onTeamsClicked(evt:js.html.Event):Void {
        MainMenuSignals.uiCkick.dispatch();
        dispatch(MainMenuActions.SetPage(Page.TEAMS));
    }

    function onHelpClicked(evt:js.html.Event):Void {
        MainMenuSignals.uiCkick.dispatch();
        dispatch(MainMenuActions.SetPage(Page.HELP));
    }

}