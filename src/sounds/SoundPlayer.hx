package sounds;

import phasergame.PhaserGame.PhaserGameActions;
import model.DataTypes.Page;
import htmlcontrols.mainmenu.MainMenu.MainMenuActions;
import howler.Howl;

class SoundPlayer {

    private var sndVictory:Howl;
    private var sndTheme:Howl;
    private var sndClick:Howl;
    private var sndHit:Howl;

    public function new() {
        sndVictory = new Howl(getOptionByFlieName("victory.mp3"));
        sndClick = new Howl(getOptionByFlieName("click.mp3"));
        sndHit = new Howl(getOptionByFlieName("hit.mp3"));
        sndTheme = new Howl(getOptionByFlieName("theme.mp3"));

        MainMenuActions.navigateToPage.add(onButtonClick);
        MainMenuActions.startGame.add(onStartGame);
        PhaserGameActions.gameEnd.add(onEndGame);
        PhaserGameActions.mobSlayed.add(onMobSlayed);
    }

    private function getOptionByFlieName(fileName:String):HowlOptions {
        var options:HowlOptions = {};
        options.src = ["sounds/"+fileName];
        options.autoplay = false;
        options.loop = false;
        return options;
    }

    private function onButtonClick(page:Page):Void {
        sndClick.play();
    }

    private function onStartGame(page:Page):Void {
        sndClick.play();
        sndTheme.play();
    }

    private function onEndGame():Void {
        sndTheme.stop();
        sndVictory.play();
    }

    private function onMobSlayed():Void {
        sndHit.play();
    }
}