package htmlcontrols.mainmenu.lobby;


import model.DataTypes.PlayerColor;
import model.DataTypes.MovingObjectState;
import model.DataTypes.ControlType;
import model.DataTypes.PlayerType;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef LobbyProps = {
    var slots:Array<MovingObjectState>;
}

class LobbyPanel extends ReactComponentOfProps<LobbyProps> {

    public function new(props:LobbyProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<div>{this.createChildren()}</div>');
    }

    function createChildren():Array<ReactElement>
    {
        return [for (i in 0...props.slots.length) jsx('<div className="menuSlot">
            <div className="hidden"><TextInput className="hidden" defaultValue="${props.slots[i].label}" id="${getNameId(i)}"/></div>
            <div className="hidden"><TextInput className="hidden" defaultValue="${this.getXY(i)}" id="${getSpawnId(i)}"/></div>

            <SelectInput className="fifthWidth" defaultValue="${props.slots[i].charType}" id="${getClassId(i)}" options=${this.getOptionsClass()}/>
            <SelectInput className="fifthWidth" defaultValue="${props.slots[i].control}" id="${getControlId(i)}" options=${this.getOptionsControl()}/>
            <SelectInput className="fifthWidth" defaultValue="${Utils.getColorBySkin(props.slots[i].skin)}" id="${getSkinId(i)}" options=${this.getOptionsSkin()}/>
        </div>')];
    }

    function getNameId(i:Int):String { return 'slot${i}Label'; }
    function getClassId(i:Int):String { return 'slot${i}Class'; }
    function getControlId(i:Int):String { return 'slot${i}Control'; }
    function getSpawnId(i:Int):String { return 'slot${i}Spawn'; }
    function getSkinId(i:Int):String { return 'slot${i}Skin'; }

    function getXY(i:Int):String {
        return '${props.slots[i].x},${props.slots[i].y}';
    }

    function getOptionsClass():Array<String> { return [
        PlayerType.HORSEMAN,
        PlayerType.BOWMAN,
        PlayerType.ELF,
        PlayerType.MAGE,
        PlayerType.SWORDMAN,
        PlayerType.ASSASSIN];
    }

    function getOptionsControl():Array<String> { return [
        ControlType.MOUSE,
        ControlType.AWSD,
        ControlType.ARROWS,
        ControlType.BOT_SIMPLE,
        ControlType.BOT_HARD,
        ControlType.NONE];
    }

    function getOptionsSkin():Array<String> { return [
        PlayerColor.RED,
        PlayerColor.GREEN,
        PlayerColor.BLUE];
    }
}