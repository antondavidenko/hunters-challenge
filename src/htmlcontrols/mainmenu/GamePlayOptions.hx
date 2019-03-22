package htmlcontrols.mainmenu;

import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef GamePlayOptionsProps = {
    var data:Dynamic;
}

class GamePlayOptions extends ReactComponentOfProps<GamePlayOptionsProps> {
    public function new(props:GamePlayOptionsProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody>
        <tr>
            <td><b>Mobs amount</b></td>
            <td><b>Base exp gain</b></td>
            <td><b>Labels</b></td>
            <td><b>Screen mode</b></td>
        </tr>
        <tr>
            <td><input id="mobsAmount" type="text" placeholder="Enter mobs amount" defaultValue="5" className="quarterWidth"/></td>
            <td><input id="baseExp" type="text" placeholder="Base exp gain" defaultValue="25" className="quarterWidth"/></td>
            <td>
                <select id="labelsSwitcher" className="quarterWidth">
                    <option value="ON">ON</option>
                    <option value="OFF">OFF</option>
                </select>
            </td>
            <td>
                <select id="modeSwitcher" className="quarterWidth">
                    <option value="Windowed">Windowed</option>
                    <option value="Fullscreen">Fullscreen</option>
                </select>
            </td>
        </tr>
        </tbody></table>');
    }
}