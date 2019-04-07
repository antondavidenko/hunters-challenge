package htmlcontrols.mainmenu;

import htmlcontrols.mainmenu.store.MainMenuActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef GameModesProps = {
    var page:String;
}

class GameModes extends ReactComponentOfProps<GameModesProps> {
    public function new(props:GameModesProps):Void
    {
        super(props);
        state = {page:props.page}
        MainMenuActions.navigateToPage.add(navigateToPage);
    }

    function navigateToPage(page:Page):Void
    {
        setState({page:page});
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr><td>{showSwitcher("Local PVP", Page.PVP, onPVPClicked)}</td></tr>
        <tr><td>{showSwitcher("Player vs bots", Page.PVE, onPVEClicked)}</td></tr>
        <tr><td>{showSwitcher("TEAMS vs", Page.TEAMS, onTeansClicked)}</td></tr>
        <tr><td>{showSwitcher("HELP", Page.HELP, onHelpClicked)}</td></tr>
        </tbody></table>');
    }

    function showSwitcher(pageName:String, page:Page, pageOnClick:js.html.Event->Void):ReactElement
    {
        if (state.page != page) {
            return jsx('<button className="modeButton" onClick="${pageOnClick}">${pageName}</button>');
        } else {
            return jsx('<div className="modeButtonActive">${pageName}</div>');
        }
    }

    function onPVPClicked(evt:js.html.Event):Void { MainMenuActions.navigateToPage.dispatch(Page.PVP); }
    function onPVEClicked(evt:js.html.Event):Void { MainMenuActions.navigateToPage.dispatch(Page.PVE); }
    function onTeansClicked(evt:js.html.Event):Void { MainMenuActions.navigateToPage.dispatch(Page.TEAMS); }
    function onHelpClicked(evt:js.html.Event):Void { MainMenuActions.navigateToPage.dispatch(Page.HELP); }
}