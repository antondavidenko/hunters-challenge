package htmlcontrols.lobby;

import model.DefaultValues.Slot;
import model.PhaserGameModel.ControlType;
import model.PhaserGameModel.PlayerType;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef LobbyProps = {
    var slots:Array<Slot>;
}

class LobbyPanel extends ReactComponentOfProps<LobbyProps> {

    public function new(props:LobbyProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('
        <table cellPadding="0" cellSpacing="0"><tbody>
        <tr>
            <th><b>Name</b></th>
            <th><b>Class</b></th>
            <th><b>Control</b></th>
            <th><b>Spawn: x,y</b></th>
        </tr>
            {this.createChildren()}
        </tbody></table>');
    }

    function createChildren():Array<ReactElement>
    {
        return [for (i in 0...props.slots.length) jsx('<tr>
            <td><TextInput defaultValue="${props.slots[i].name}" id="${getNameId(i)}"/></td>
            <td><SelectInput defaultValue="${props.slots[i].charType}" id="${getClassId(i)}" options=${this.getOptionsClass()}/></td>
            <td><SelectInput defaultValue="${props.slots[i].controlType}" id="${getControlId(i)}" options=${this.getOptionsControl()}/></td>
            <td><TextInput defaultValue="${this.getXY(i)}" id="${getSpawnId(i)}"/></td>
        </tr>')];
    }

    function getNameId(i:Int):String { return 'slot${i}Name'; }
    function getClassId(i:Int):String { return 'slot${i}Class'; }
    function getControlId(i:Int):String { return 'slot${i}Control'; }
    function getSpawnId(i:Int):String { return 'slot${i}Spawn'; }

    function getXY(i:Int):String {
        return '${props.slots[i].x},${props.slots[i].y}';
    }

    function getOptionsClass():Array<String> { return [
        PlayerType.HORSEMAN,
        PlayerType.BOWMAN,
        PlayerType.ELF,
        PlayerType.MAGE,
        PlayerType.SWORDMAN]; }
    function getOptionsControl():Array<String> { return [
        ControlType.MOUSE,
        ControlType.WASD,
        ControlType.ARROWS,
        ControlType.BOT_SIMPLE,
        ControlType.BOT_HARD,
        ControlType.NONE];
    }
}