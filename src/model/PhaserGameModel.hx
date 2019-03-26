package model;

class PhaserGameModel {
    public function new() {}
}

class CharacterConfig {
    public function new() {}
    public var MOVE_SPEED : Int;
    public var MIN_DISTANCE : Int;
}

class PlayerType {
    public function new() {}

    static public var SWORDMAN = "swordman";
    static public var BOWMAN = "bowman";
    static public var ELF = "elf";
    static public var MAGE = "mage";
    static public var HORSEMAN = "horseman";
}

class ControlType {
    public function new() {}

    static public var MOUSE = "mouse";
    static public var ARROWS = "keys_arrows";
    static public var AWSD = "keys_awsd";
    static public var BOT_SIMPLE = "bot_simple";
    static public var BOT_HARD = "bot_hard";
    static public var NONE = "none";
}

class CharStartConfig {
    public function new(charType:String, x:Int, y:Int, label:String, name:String, control:String, skin:Int) {
        this.charType = charType;
        this.x = x;
        this.y = y;
        this.label = label;
        this.name = name;
        this.control = control;
        this.skin = skin;
    }

    public var charType:String;
    public var x:Int;
    public var y:Int;
    public var label:String;
    public var name:String;
    public var control:String;
    public var skin:Int;
}

class PlayerData {
    public function new(slayedCounter:Int, expGained:Float, currentLevel:Int, label:String, control:String) {
        this.slayedCounter = slayedCounter;
        this.expGained = expGained;
        this.currentLevel = currentLevel;
        this.label = label;
        this.control = control;
    }

    public var slayedCounter:Int;
    public var expGained:Float;
    public var currentLevel:Int;
    public var label:String;
    public var control:String;
}

class MobData {
    public function new(currentLevel:Int) {
        this.currentLevel = currentLevel;
    }
    public var currentLevel:Int;
}