package htmlcontrols;

import haxe.macro.Expr.ExprOf;
import htmlcontrols.store.GameActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;
import htmlcontrols.lobby.LobbyPanel;

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
            <LobbyPanel slots="${props.data.slots}"></LobbyPanel>
            <button id="loginButton">PLAY</button>
            </div>');
        } else {
            return jsx('<div>${state.page}</div>');
        }
    }
}
