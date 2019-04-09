package model;

enum Page {
    PVP;
    PVE;
    TEAMS;
    HELP;
}

typedef CharacterConfig = {
    var MOVE_SPEED:Int;
    var MIN_DISTANCE:Int;
    var IDLE_POSE_ID:Int;
    var COLISION_ANIM_ID:Int;
}

class Skin {
    static public var RED:Int = 1;
    static public var GREEN:Int = 2;
    static public var BLUE:Int = 3;
}

class PlayerType {
    static public var SWORDMAN:String = "swordman";
    static public var BOWMAN:String = "bowman";
    static public var ELF:String = "elf";
    static public var MAGE:String = "mage";
    static public var HORSEMAN:String = "horseman";
}

class ControlType {
    static public var MOUSE:String = "mouse";
    static public var ARROWS:String = "keys_arrows";
    static public var AWSD:String = "keys_awsd";
    static public var BOT_SIMPLE:String = "bot_simple";
    static public var BOT_HARD:String = "bot_hard";
    static public var NONE:String = "none";
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
    public function new(slayedCounter:Int, expGained:Float, currentLevel:Int, label:String, control:String, teamId:Int) {
        this.slayedCounter = slayedCounter;
        this.expGained = expGained;
        this.currentLevel = currentLevel;
        this.label = label;
        this.control = control;
        this.teamId = teamId;
    }

    public var slayedCounter:Int;
    public var expGained:Float;
    public var currentLevel:Int;
    public var label:String;
    public var control:String;
    public var teamId:Int;
}

class MobData {
    public function new(currentLevel:Int) {
        this.currentLevel = currentLevel;
    }
    public var currentLevel:Int;
}

class Slot {
    public function new(label:String, charType:String, controlType:String, x:Int, y:Int, name:String, skin:Int) {
        this.name = name;
        this.controlType = controlType;
        this.charType = charType;
        this.x = x;
        this.y = y;
        this.label = label;
        this.skin = skin;
    }

    public var name:String;
    public var charType:String;
    public var x:Int;
    public var y:Int;
    public var controlType:String;
    public var label:String;
    public var skin:Int;
}

typedef GameConfiguration = {
    var slots:Array<Slot>;
    var screenMode:String;
    var showLabel:Bool;
    var baseExpGain:Float;
    var mobAmount:Int;
}