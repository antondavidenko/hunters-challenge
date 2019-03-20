package htmlcontrols;

import htmlcontrols.store.GameActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef GameModesProps = {
    var data:Dynamic;
}

class GameModes extends ReactComponentOfProps<GameModesProps> {
    public function new(props:GameModesProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody><tr>
        <td><button id="b1" className="modeButton" onClick="$onPVPClicked">Local PVP</button></td>
        <td><button id="b2" className="modeButton" onClick="$onPVEClicked">Player vs bots</button></td>
        <td><button id="b3" className="modeButton" onClick="$onTeansClicked">TEAMS vs</button></td>
        <td><button id="b4" className="modeButton" onClick="$onHelpClicked">HELP</button></td>
        </tr></tbody></table>');
    }

    function onPVPClicked(evt:js.html.Event):Void { GameActions.jumpTo.dispatch(GameActions.pagePVP); }
    function onPVEClicked(evt:js.html.Event):Void { GameActions.jumpTo.dispatch(GameActions.pagePVE); }
    function onTeansClicked(evt:js.html.Event):Void { GameActions.jumpTo.dispatch(GameActions.pageTeams); }
    function onHelpClicked(evt:js.html.Event):Void { GameActions.jumpTo.dispatch(GameActions.pageHelp); }
}