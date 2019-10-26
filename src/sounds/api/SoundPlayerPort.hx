package sounds.api;

class SoundPlayerPort {

    private static var soundPlayer:SoundPlayer;

    static public function executeStart():Void {
        soundPlayer = new SoundPlayer();
    }

}
