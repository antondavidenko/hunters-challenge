package sidepanel.view;

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

        var imageClassList:Map<String, String> = [
            "swordman" => "SWORDMAN",
            "bowman" => "BOWMAN",
            "elf" => "ELF",
            "mage" => "MAGE",
            "horseman" => "HORSEMAN",
            "assassin" => "ASSASSIN"];
        var itemAvatarImageClassId = imageClassList[item.classImageId];

        var imageColorsList:Map<Int, String> = [
            1 => "RED_BANNER",
            2 => "BLUE_BANNER",
            3 => "GREEN_BANNER"];
        var itemColorImageClassId = imageColorsList[Std.parseInt(item.colorImageId)];

        return jsx('<div>
            <img className=$itemAvatarImageClassId/>
            <img className=$itemColorImageClassId/>
            <label><b>${item.label}</b></label><br/>
            <label><b>${item.progress}</b></label><br/><br/>
        </div>');
    }
}
