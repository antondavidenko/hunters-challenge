package htmlcontrols.mainmenu;

import htmlcontrols.store.GameActions;
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
        GameActions.navigateToPage.add(navigateToPage);
    }

    function navigateToPage(page:String):Void
    {
        setState({page:page});
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr><td>{showSwitcher("Local PVP", GameActions.pagePVP, onPVPClicked)}</td></tr>
        <tr><td>{showSwitcher("Player vs bots", GameActions.pagePVE, onPVEClicked)}</td></tr>
        <tr><td>{showSwitcher("TEAMS vs", GameActions.pageTeams, onTeansClicked)}</td></tr>
        <tr><td>{showSwitcher("HELP", GameActions.pageHelp, onHelpClicked)}</td></tr>
        </tbody></table>');
    }

    function showSwitcher(pageName:String, pageId:String, pageOnClick:js.html.Event->Void):ReactElement
    {
        if (state.page != pageId) {
            return jsx('<button className="modeButton" onClick="${pageOnClick}">${pageName}</button>');
        } else {
            return jsx('<div className="modeButtonActive">${pageName}</div>');
        }
    }

    function onPVPClicked(evt:js.html.Event):Void { GameActions.navigateToPage.dispatch(GameActions.pagePVP); }
    function onPVEClicked(evt:js.html.Event):Void { GameActions.navigateToPage.dispatch(GameActions.pagePVE); }
    function onTeansClicked(evt:js.html.Event):Void { GameActions.navigateToPage.dispatch(GameActions.pageTeams); }
    function onHelpClicked(evt:js.html.Event):Void { GameActions.navigateToPage.dispatch(GameActions.pageHelp); }
}