package htmlcontrols.mainmenu.lobby;

import htmlcontrols.store.GameActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef TextInputProps = {
    var defaultValue:String;
    var id:String;
    var className:String;
}

class TextInput extends ReactComponentOfProps<TextInputProps> {

    public function new(props:TextInputProps):Void {
        super(props);
        state = {value:props.defaultValue};
    }

    public override function componentWillReceiveProps(newProps:TextInputProps) {
        this.setState({value:newProps.defaultValue});
    }

    public override function render():ReactElement {
        return jsx('<input id=${props.id} className=${props.className} type="text" value="${state.value}" onChange="${onChange}"/>');
    }

    private function onChange(event):Void {
        this.setState({value:event.target.value});
    }
}

