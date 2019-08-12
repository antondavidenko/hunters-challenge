package phasergame;

import msignal.Signal.Signal1;
import msignal.Signal.Signal0;

class PhaserGameSignals {
    public static var gameEnd:Signal0 = new Signal0();
    public static var countUpFinish:Signal0 = new Signal0();
    public static var countUpProgress:Signal1<Int> = new Signal1();
    public static var mobSlayed:Signal1<Int> = new Signal1();
}
