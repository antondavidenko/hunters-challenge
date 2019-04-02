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
            <th className="fifthWidth"><b>Mobs amount</b></th>
            <th className="fifthWidth"><b>Base exp gain</b></th>
            <th className="fifthWidth"><b>Labels</b></th>
            <th className="fifthWidth"><b>Screen mode</b></th>
        </tr>
        <tr>
            <td><input id="mobsAmount" type="text" placeholder="Enter mobs amount" defaultValue="5" className="fifthWidth"/></td>
            <td><input id="baseExp" type="text" placeholder="Base exp gain" defaultValue="25" className="fifthWidth"/></td>
            <td>
                <select id="labelsSwitcher" className="fifthWidth">
                    <option value="ON">ON</option>
                    <option value="OFF">OFF</option>
                </select>
            </td>
            <td>
                <select id="modeSwitcher" className="fifthWidth">
                    <option value="Windowed">Windowed</option>
                    <option value="Fullscreen">Fullscreen</option>
                </select>
            </td>
        </tr>
        </tbody></table>');
    }
}