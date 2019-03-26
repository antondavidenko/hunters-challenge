package htmlcontrols.mainmenu.lobby;

import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

typedef SelectInputProps = {
    var defaultValue:String;
    var id:String;
    var options:Array<String>;
}

class SelectInput extends ReactComponentOfProps<SelectInputProps> {

    public function new(props:SelectInputProps):Void {
        super(props);
        state = {value:props.defaultValue};
    }

    public override function componentWillReceiveProps(newProps:SelectInputProps) {
        this.setState({value:newProps.defaultValue});
    }

    public override function render():ReactElement {
        return jsx('<select className="fifthWidth" value="${state.value}" id=${props.id} onChange="${onChange}">
        {this.createOptions()}
        </select>');
    }

    public function createOptions():Array<ReactElement> {
        return [for (i in 0...props.options.length) jsx('
        <option value="${props.options[i]}">${props.options[i]}</option>
        ')];
    }

    private function onChange(event):Void {
        this.setState({value:event.target.value});
    }
}
