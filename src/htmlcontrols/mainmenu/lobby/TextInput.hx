package htmlcontrols.mainmenu.lobby;

import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef TextInputProps = {
    var defaultValue: String;
    var id: String;
}

class TextInput extends ReactComponentOfProps<TextInputProps> {

    public function new(props:TextInputProps):Void { super(props); }

    public override function render():ReactElement
    {
        return jsx('<input id=${props.id} type="text" value="${props.defaultValue}" className="quarterWidth" onChange="${onChange}"/>');
    }

    private function onChange():Void {}
}

