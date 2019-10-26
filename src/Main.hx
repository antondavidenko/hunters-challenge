import sidepanel.api.SidePanelPort;
import sounds.api.SoundPlayerPort;
import phasergame.api.PhaserGamePort;
import phasergame.api.GameStateOutcomingDTO;
import mainmenu.api.MainMenuPort;
import mainmenu.api.MainMenuStateOutcomingDTO;
import common.converters.SidePanelStateConverter;
import common.converters.GameConfigurationConverter;
import common.loader.Loader;

class Main {

    static function main() {
        return new Main();
    }

    public function new() {
        Loader.loadAll(init);
    }

    public function init() {
        startAllComponents();
        addListeners();
    }

    private function startAllComponents() {
        PhaserGamePort.executeStart();
        MainMenuPort.executeStart();
        SidePanelPort.executeStart();
        SoundPlayerPort.executeStart();
    }

    private function addListeners() {
        MainMenuPort.onStartGame(onStartGame);
        PhaserGamePort.onGameStateUpdate(onGameStateUpdate);
    }

    private function onStartGame(configuration:MainMenuStateOutcomingDTO):Void {
        PhaserGamePort.executeStartGame(GameConfigurationConverter.convertMainMenuStateOutcomingDTO(configuration));
        SidePanelPort.executeStartGame();
        MainMenuPort.executeHide();
        setFullscreenIfRequired(configuration.isFullscreen);
    }

    private function setFullscreenIfRequired(isFullscreen: Bool) {
        if (isFullscreen) {
            cast js.Browser.document.getElementById("HTML5game").requestFullscreen();
        }
    }

    private function onGameStateUpdate(state:GameStateOutcomingDTO):Void {
        SidePanelPort.executeUpdateView(SidePanelStateConverter.convertGameStateOutcomingDTO(state));
    }

}