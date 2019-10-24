package mainmenu.view.components;

import mainmenu.api.MainMenuPort;
import mainmenu.action.MainMenuActions;
import redux.react.IConnectedComponent;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef ScreenBoxProps = {
    selectedValue:Bool,
    boxValue:Bool,
    label:String
}

class ScreenBox extends ReactComponentOfProps<ScreenBoxProps> implements IConnectedComponent {
    public function new(props:ScreenBoxProps):Void {
        super(props);
    }

    public override function render():ReactElement {
        var style = props.selectedValue == props.boxValue ? "anyControl selectedControl" : "anyControl";

        return jsx('<div className=${style} onClick=$onClick>${props.label}</div>');
    }

    function onClick() {
        MainMenuPort.doUiCkick();
        dispatch(MainMenuActions.SetFullscreen(props.boxValue));
    }
}
