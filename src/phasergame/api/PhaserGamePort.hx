package phasergame.api;

import phasergame.model.PhaserGameModel;
import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

class PhaserGamePort {

    private static var gameEnd:Signal0 = new Signal0();
    private static var countUpFinish:Signal0 = new Signal0();
    private static var countUpProgress:Signal1<Int> = new Signal1();
    private static var mobSlayed:Signal1<Int> = new Signal1();
    private static var gameStateUpdate:Signal1<GameStateOutcomingDTO> = new Signal1();

    private static var phaserGame:PhaserGame;

    static public function executeStart():Void {
        phaserGame = new PhaserGame();
    }

    static public function executeStartGame(config:GameConfigurationIncomingDTO):Void {
        PhaserGameModel.init(config);
        phaserGame.init();
        phaserGame.show();
    }

    static public function setData(data:Dynamic):Void {
        phasergame.model.DefaultValues.setData(data);
    }

    static public function doGameEnd():Void {
        gameEnd.dispatch();
    }

    static public function onGameEnd(listener:Void->Void):Void {
        gameEnd.add(listener);
    }

    static public function doCountUpFinish():Void {
        countUpFinish.dispatch();
    }

    static public function onCountUpFinish(listener:Void->Void):Void {
        countUpFinish.add(listener);
    }

    static public function doCountUpProgress(count:Int):Void {
        countUpProgress.dispatch(count);
    }

    static public function onCountUpProgress(listener:Int->Void):Void {
        countUpProgress.add(listener);
    }

    static public function doMobSlayed(mobLvl:Int):Void {
        mobSlayed.dispatch(mobLvl);
    }

    static public function onMobSlayed(listener:Int->Void):Void {
        mobSlayed.add(listener);
    }

    static public function doGameStateUpdate(gameState:GameStateOutcomingDTO):Void {
        gameStateUpdate.dispatch(gameState);
    }

    static public function onGameStateUpdate(listener:GameStateOutcomingDTO->Void):Void {
        gameStateUpdate.add(listener);
    }

}