package sidepanel;

import sidepanel.model.DataTypes.SidePanelItem;

class SidePanelStateIncomingDTO {

    public var items:Array<SidePanelItem>;

    public function new (items:Array<SidePanelItem>) {
        this.items = items;
    }

}
