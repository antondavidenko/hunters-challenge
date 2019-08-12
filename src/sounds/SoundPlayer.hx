package sounds;

import mainmenu.PublicAPI.MainMenuSignals;
import phasergame.PublicAPI.PhaserGameSignals;
import howler.Howl;

class SoundPlayer {

    private var sndVictory:Howl;
    private var sndTheme:Howl;
    private var sndClick:Howl;
    private var hitSndList:Array<Howl>;
    private var countUpList:Array<Howl>;

    public function new() {
        sndVictory = new Howl(getOptionByFlieName("victory.mp3"));
        sndClick = new Howl(getOptionByFlieName("click.mp3"));
        sndTheme = new Howl(getOptionByFlieName("theme.mp3"));

        var sndAnimal:Howl = new Howl(getOptionByFlieName("animal.mp3"));
        var sndZombie:Howl = new Howl(getOptionByFlieName("zombie.mp3"));
        var sndDragon:Howl = new Howl(getOptionByFlieName("dragon.mp3"));
        hitSndList = [sndAnimal, sndZombie, sndZombie, sndDragon, sndDragon];

        var count1:Howl = new Howl(getOptionByFlieName("count_1.mp3"));
        var count2:Howl = new Howl(getOptionByFlieName("count_2.mp3"));
        var count3:Howl = new Howl(getOptionByFlieName("count_3.mp3"));
        var countGO:Howl = new Howl(getOptionByFlieName("count_GO.mp3"));
        countUpList = [count1, count2, count3, countGO];

        MainMenuSignals.navigateToPage.add(onButtonClick);
        MainMenuSignals.startGame.add(onButtonClick);
        PhaserGameSignals.countUpFinish.add(onCountUpFinish);
        PhaserGameSignals.countUpProgress.add(onCountUpProgress);
        PhaserGameSignals.gameEnd.add(onEndGame);
        PhaserGameSignals.mobSlayed.add(onMobSlayed);
    }

    private function getOptionByFlieName(fileName:String):HowlOptions {
        var options:HowlOptions = {};
        options.src = ["sounds/"+fileName];
        options.autoplay = false;
        options.loop = false;
        return options;
    }

    private function onButtonClick(e:Dynamic):Void {
        sndClick.play();
    }

    private function onCountUpFinish():Void {
        sndTheme.play();
    }

    private function onEndGame():Void {
        sndTheme.stop();
        sndVictory.play();
    }

    private function onMobSlayed(mobLvl:Int):Void {
        hitSndList[mobLvl-1].play();
    }

    private function onCountUpProgress(count:Int):Void {
        countUpList[count].play();
    }
}