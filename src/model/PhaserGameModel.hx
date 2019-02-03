package model;

class PhaserGameModel {
    public function new() {
    }
}

class CharacterConfig {
    public function new() {}
    public var DEFAULT_POSE_ID : Int;
    public var MOVE_SPEED : Int;
    public var MIN_DISTANCE : Int;
}

class CharType {
    public function new() {}

    static public var SWORDMAN = "swordman";
    static public var BOWMAN = "bowman";
    static public var ELF = "elf";
    static public var MAGE = "mage";
    static public var HORSEMAN = "horseman";
}

class MobLabel {
    public function new() {}

    static public var MOB1LVL = "lvl 1";
    static public var MOB2LVL = "lvl 2";
    static public var MOB3LVL = "lvl 3";
    static public var MOB4LVL = "lvl 4";
    static public var MOB5LVL = "lvl 5";
}

class MobType {
    public function new() {}

    static public var MOB1LVL = "mob1lvl";
    static public var MOB2LVL = "mob2lvl";
    static public var MOB3LVL = "mob3lvl";
    static public var MOB4LVL = "mob4lvl";
    static public var MOB5LVL = "mob5lvl";
}

class CharStartConfig {
    public function new(charType:String, x:Int, y:Int, label:String) {
        this.charType = charType;
        this.x = x;
        this.y = y;
        this.label = label;
    }

    public var charType:String;
    public var x:Int;
    public var y:Int;
    public var label:String;
}