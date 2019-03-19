package htmlcontrols;

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
    }

    public override function render():ReactElement
    {
        return jsx('<div>
        <h2>GAME-PLAY OPTIONS</h2>
        <GamePlayOptions></GamePlayOptions>
        <h2>MODES</h2>
        <GameModes></GameModes>
        <h2>LOBBY</h2>
        <LobbyPanel slots="${props.data.slots}"></LobbyPanel>
        <button id="loginButton">PLAY</button>
        </div>');
    }
}
