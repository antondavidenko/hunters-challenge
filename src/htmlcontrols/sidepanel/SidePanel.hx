package htmlcontrols.sidepanel;

import model.PhaserGameModel.CharStartConfig;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef SidePanelProps = {
    var players:Array<CharStartConfig>;
}

class SidePanel extends ReactComponentOfProps<SidePanelProps> {

    public function new(props:SidePanelProps):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<div>{this.createChildren()}</div>');
    }

    function createChildren():Array<ReactElement>
    {
        return [for (i in 0...props.players.length) jsx('<div>
            <label id="${getNameId(i)}"><b>Name holder</b></label>
            <div className="expBarBg">
                    <div className="${getProgressClass(i)}" id="${getProgressId(i)}"></div>
        </div><br/></div>')];
    }

    function getNameId(i:Int):String { return 'sidePanel_name${i}'; }
    function getProgressId(i:Int):String { return 'sidePanel_Player${i}progress'; }
    function getProgressClass(i:Int):String { return 'Player${i}progress expBarBgProgress'; }
}