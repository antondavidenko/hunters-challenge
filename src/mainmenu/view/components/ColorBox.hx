package mainmenu.view.components;

import mainmenu.api.MainMenuPort;
import mainmenu.action.MainMenuActions;
import redux.react.IConnectedComponent;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import mainmenu.model.DataTypes.LobbyItemState;
import react.ReactMacro.jsx;

typedef ColorBoxProps = {
    item:LobbyItemState,
    colorId:String,
    colorHex:String
}

class ColorBox extends ReactComponentOfProps<ColorBoxProps> implements IConnectedComponent {
    public function new(props:ColorBoxProps):Void {
        super(props);
    }

    public override function render():ReactElement {

        var check = (props.item.color == props.colorId)?"checked":"";
        var style = { backgroundColor:props.colorHex };

        return jsx('<label className="container">
            <input type="checkbox" checked=$check onChange=$onClick/>
            <span className="checkmark" style=$style></span>
        </label>');
    }

    function onClick() {
        MainMenuPort.doUiCkick();
        dispatch(MainMenuActions.SetColor(props.item.id, props.colorId));
    }
}
