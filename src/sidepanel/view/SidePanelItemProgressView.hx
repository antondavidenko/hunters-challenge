package sidepanel.view;

import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef SidePanelItemProgressProps = {
    var progress:Int;
}

class SidePanelItemProgressView extends ReactComponentOfProps<SidePanelItemProgressProps> {

    public function new() {
        super(props);
    }

    public override function render():ReactElement {

        var style = { width:props.progress + "%" };

        return jsx('<div className="expBarBg">
                <div className="expBarBgProgress" style="${style}"></div>
                <div className="expBarSectionContainer">
                    <div className="expBarSection"></div>
                    <div className="expBarSection"></div>
                    <div className="expBarSection"></div>
                    <div className="expBarSection"></div>
                    <div className="expBarSection"></div>
                </div>
        </div>');
    }

}
