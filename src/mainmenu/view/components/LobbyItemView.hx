package mainmenu.view.components;

import js.jquery.Event;
import mainmenu.model.DefaultValues;
import mainmenu.model.DataTypes.LobbyItemState;
import mainmenu.action.MainMenuActions;
import mainmenu.model.Lobby;
import react.ReactComponent;
import react.ReactMacro.jsx;
import redux.react.IConnectedComponent;

typedef LobbyItemItemProps = {
    item:LobbyItemState
};

class LobbyItemView extends ReactComponentOfProps<LobbyItemItemProps> implements IConnectedComponent {
    override public function render() {
        var item:LobbyItemState = props.item;
        var itemAvatarImageClassId = DefaultValues.imageClassesIdList[item.classId - 1];
        var itemIngameImageClassId = '${itemAvatarImageClassId}_${item.color} ingameImage';
        var itemId:Int = Std.parseInt(item.id)-1;

        return jsx('
            <div className="menuSlot">
                <button className="classButton" onClick=$onMinusClick>&lt;</button>
                <img className=$itemAvatarImageClassId/>
                <div className="ingameImageHolder"><img className=$itemIngameImageClassId/></div>
                <button className="classButton" onClick=$onPlusClick>&gt;</button>

                ${renderControlsList(DefaultValues.showControlList[itemId])}

                <ColorBox item=$item colorId="R" colorHex="#d03310"/>
                <ColorBox item=$item colorId="G" colorHex="#50bb10"/>
                <ColorBox item=$item colorId="B" colorHex="#2099d0"/>
            </div>
        ');
    }

    function renderControlsList(list:Array<String>) {
        return [for (i in 0...list.length)
            jsx('<ControlBox item=${props.item} controlId=$i label=${list[i]}/>')
        ];
    }

    override public function shouldComponentUpdate(nextProps:LobbyItemItemProps, nextState:Dynamic):Bool {
        return nextProps.item != props.item;
    }

    function onMinusClick() {
        var newClassId = props.item.classId - 1;
        newClassId = newClassId == 0 ? DefaultValues.imageClassesIdList.length : newClassId;
        dispatch(MainMenuActions.SetClass(props.item.id, newClassId));
    }

    function onPlusClick() {
        var newClassId = props.item.classId + 1;
        newClassId = newClassId > DefaultValues.imageClassesIdList.length ? 1 : newClassId;
        dispatch(MainMenuActions.SetClass(props.item.id, newClassId));
    }
}