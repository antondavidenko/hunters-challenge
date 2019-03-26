package htmlcontrols.mainmenu;

import haxe.macro.Expr.ExprOf;
import htmlcontrols.store.GameActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;
import htmlcontrols.mainmenu.lobby.LobbyPanel;
import htmlcontrols.mainmenu.helppage.HelpPage;

typedef MainMenuProps = {
    var data:Dynamic;
}

class MainMenu extends ReactComponentOfProps<MainMenuProps> {

    public function new(props:MainMenuProps):Void
    {
        super(props);
        state = {page:props.data.page, slots:defineSlotsForPage(props.data.page)}
        GameActions.navigateToPage.add(navigateToPage);
    }

    function navigateToPage(page:String):Void
    {
        setState({page:page, slots:defineSlotsForPage(page)});
    }

    private function defineSlotsForPage(page:String):Array<Dynamic> {
        if (page == GameActions.pagePVP) {
            return props.data.slotsPVP;
        } else if (page == GameActions.pagePVE) {
            return props.data.slotsPVE;
        } else if (page == GameActions.pageTeams) {
            return props.data.slotsTEAMS;
        } else {
            return [];
        }
    }

    public override function render():ReactElement
    {
        return jsx('<div>
        <h2>GAME-PLAY OPTIONS</h2>
        <GamePlayOptions></GamePlayOptions>
        <h2>MAIN MENU</h2>
        <GameModes></GameModes>
        {this.getContentByState()}
        </div>');
    }

    function getContentByState():ReactElement
    {
        if (state.page == GameActions.pagePVP) {
            return jsx('<div>
            <h2>PVP LOBBY</h2>
            <LobbyPanel slots="${state.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onPVPClicked">PLAY</button>
            </div>');
        } else if (state.page == GameActions.pagePVE) {
            return jsx('<div>
            <h2>PVE LOBBY</h2>
            <LobbyPanel slots="${state.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onPVEClicked">PLAY</button>
            </div>');
        } else if (state.page == GameActions.pageTeams) {
            return jsx('<div>
            <h2>TEAMS LOBBY</h2>
            <LobbyPanel slots="${state.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onTEAMSClicked">PLAY</button>
            </div>');
        } else if (state.page == GameActions.pageHelp) {
            return jsx('<div>
            <h2>HELP</h2>
            <HelpPage></HelpPage>
            </div>');
        } else {
            return jsx('<div>404 page:${state.page} is not found</div>');
        }
    }

    function onPVPClicked(evt:js.html.Event):Void { GameActions.startGame.dispatch(GameActions.pagePVP); }
    function onPVEClicked(evt:js.html.Event):Void { GameActions.startGame.dispatch(GameActions.pagePVE); }
    function onTEAMSClicked(evt:js.html.Event):Void { GameActions.startGame.dispatch(GameActions.pageTeams); }
}
