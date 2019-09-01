package sidepanel.view;

import sidepanel.model.DataTypes.SidePanelItem;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef SidePanelProps = {
    var itemsList:Array<SidePanelItem>;
}

class SidePanel extends ReactComponentOfProps<SidePanelProps> {

    public function new(props:SidePanelProps):Void {
        super(props);
    }

    public override function render():ReactElement {
        return jsx('<div>{this.createChildren()}
        <button className="restartButton" id="restartButton" onClick="$onRestartCicked">RESTART</button>
        </div>');
    }

    function createChildren():Array<ReactElement> {
        return [for (i in 0...props.itemsList.length) jsx('<SidePanelItemView item="${props.itemsList[i]}"/>')];
    }

    function onRestartCicked(evt:js.html.Event):Void {
        var pageURL:String =  js.Browser.window.location.href;
        js.Browser.window.location.href = pageURL;
    }
}