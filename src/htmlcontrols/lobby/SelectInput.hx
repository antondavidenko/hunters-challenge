package htmlcontrols.lobby;

import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef SelectInputProps = {
    var defaultValue: String;
    var id: String;
    var options:Array<String>;
}

class SelectInput extends ReactComponentOfProps<SelectInputProps>  {

    public function new(props:SelectInputProps):Void { super(props); }

    public override function render():ReactElement
    {
        return jsx('<select className="quarterWidth" defaultValue="${props.defaultValue}" id=${props.id}>{this.createOptions()}</select>');
    }

    public function createOptions():Array<ReactElement> {
        return [for (i in 0...props.options.length) jsx('
        <option value="${props.options[i]}">${props.options[i]}</option>
        ')];
    }
}
