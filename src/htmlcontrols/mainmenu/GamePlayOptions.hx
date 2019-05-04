package htmlcontrols.mainmenu;

import model.DataTypes.Page;
import model.DataTypes.GameConfiguration;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef GamePlayOptionsProps = {
    var data:Map<Page, GameConfiguration>;
    var page:Page;
}

class GamePlayOptions extends ReactComponentOfProps<GamePlayOptionsProps> {
    public function new(props:GamePlayOptionsProps):Void
    {
        super(props);
        state = {mobAmount:props.data[props.page].mobAmount, page:props.page};
    }

    public override function render():ReactElement
    {
        if (state.page != props.page) {
            state = {mobAmount:props.data[props.page].mobAmount, page:props.page};
        }
        return jsx('<table><tbody>
        <tr>
            <th className="fifthWidth"><b>Mobs amount</b></th>
            <th className="fifthWidth"><b>Base exp gain</b></th>
            <th className="fifthWidth"><b>Labels</b></th>
            <th className="fifthWidth"><b>Screen mode</b></th>
        </tr>
        <tr>
            <td><input id="mobsAmount" type="text" placeholder="Enter mobs amount" value="${state.mobAmount}" className="fifthWidth" onChange="${onChange}"/></td>
            <td><input id="baseExp" type="text" placeholder="Base exp gain" defaultValue="25" className="fifthWidth"/></td>
            <td>
                <select id="labelsSwitcher" className="fifthWidth">
                    <option value="ON">ON</option>
                    <option value="OFF">OFF</option>
                </select>
            </td>
            <td>
                <select id="modeSwitcher" className="fifthWidth">
                    <option value="Fullscreen">Fullscreen</option>
                    <option value="Windowed">Windowed</option>
                </select>
            </td>
        </tr>
        </tbody></table>');
    }

    private function onChange(event):Void {
        var page = state.page;
        this.setState({mobAmount:event.target.value, page:page});
    }
}