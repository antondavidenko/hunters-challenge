package mainmenu.view.components;

import mainmenu.api.MainMenuPort;
import mainmenu.action.MainMenuActions;
import mainmenu.model.DataTypes.LobbyItemState;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;
import redux.react.IConnectedComponent;

typedef ControlBoxProps = {
    item:LobbyItemState,
    controlId:Int,
    label:String
}

class ControlBox extends ReactComponentOfProps<ControlBoxProps> implements IConnectedComponent {
    public function new(props:ControlBoxProps):Void {
        super(props);
    }

    public override function render():ReactElement {
        var style = props.controlId == props.item.controlId ? "anyControl selectedControl" : "anyControl";

        return jsx('<div className=${style} onClick=$onClick>${props.label}</div>');
    }

    function onClick() {
        MainMenuPort.doUiCkick();
        dispatch(MainMenuActions.SetControl(props.item.id, props.controlId));
    }
}
