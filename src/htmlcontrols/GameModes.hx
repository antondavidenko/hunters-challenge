package htmlcontrols;

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
        <td><button id="b1" className="modeButton">Local PVP</button></td>
        <td><button id="b2" className="modeButton">Player vs bots</button></td>
        <td><button id="b3" className="modeButton">TEAMS vs</button></td>
        <td><button id="b4" className="modeButton">HELP</button></td>
        </tr></tbody></table>');
    }
}