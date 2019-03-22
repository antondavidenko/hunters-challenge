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
        state = {page:props.data.page}
        GameActions.jumpTo.add(jumpTo);
    }

    function jumpTo(page:String):Void
    {
        setState({page:page});
    }

    public override function render():ReactElement
    {
        return jsx('<div>
        <h2>GAME-PLAY OPTIONS</h2>
        <GamePlayOptions></GamePlayOptions>
        <h2>MODES</h2>
        <GameModes></GameModes>
        {this.getContentByState()}
        </div>');
    }

    function getContentByState():ReactElement
    {
        if (state.page == GameActions.pagePVP) {
            return jsx('<div>
            <h2>LOBBY</h2>
            <LobbyPanel slots="${props.data.slotsPVP}"></LobbyPanel>
            <button id="loginButton">PLAY</button>
            </div>');
        } else if (state.page == GameActions.pagePVE) {
                return jsx('<div>
            <h2>LOBBY</h2>
            <LobbyPanel slots="${props.data.slotsPVE}"></LobbyPanel>
            <button id="loginButton">PLAY</button>
            </div>');
        } else if (state.page == GameActions.pageHelp) {
            return jsx('<div>
            <h2>HELP</h2>
            <HelpPage></HelpPage>
            </div>');
        } else {
            return jsx('<div><h2>TEAMS VS</h2><div>Teams page are in progress...</div></div>');
        }
    }
}
