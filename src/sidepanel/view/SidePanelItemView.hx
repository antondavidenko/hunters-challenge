package sidepanel.view;

import sidepanel.model.DefaultValues;
import sidepanel.model.DataTypes.SidePanelItem;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactComponent.ReactElement;
import react.ReactMacro.jsx;

typedef SidePanelItemProps = {
    var item:SidePanelItem;
}

class SidePanelItemView extends ReactComponentOfProps<SidePanelItemProps> {

    public function new() {
        super(props);
    }

    public override function render():ReactElement {

        var item:SidePanelItem = props.item;
        var itemAvatarImageClassId = DefaultValues.imageClassList[item.classImageId];
        var itemColorImageClassId = DefaultValues.imageColorsList[Std.parseInt(item.colorImageId)];

        return jsx('<div>
            <img className=$itemAvatarImageClassId/>
            <img className=$itemColorImageClassId/>
            <div className="sidePanelLabel">${item.label}</div><br/>
            <SidePanelItemProgressView progress=${item.progress}/>
            <br/><br/>
        </div>');
    }

}
