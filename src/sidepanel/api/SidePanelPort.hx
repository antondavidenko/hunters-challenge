package sidepanel.api;

class SidePanelPort {

    private static var sidePanelControl:SidePanelControl;

    static public function executeStartGame():Void {
        sidePanelControl.init();
        sidePanelControl.show();
    }

    static public function executeUpdateView(state:SidePanelStateIncomingDTO):Void {
        sidePanelControl.updateView(state);
    }

    static public function executeStart():Void {
        sidePanelControl = new SidePanelControl();
    }

}
