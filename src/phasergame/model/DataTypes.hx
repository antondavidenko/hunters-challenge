package phasergame.model;

enum Page {
    PVP;
    PVE;
    TEAMS;
    HELP;
}

class PlayerColor {
    static public inline var RED:String = "red";
    static public inline var GREEN:String = "green";
    static public inline var BLUE:String = "blue";
}

class PlayerType {
    static public inline var SWORDMAN:String = "swordman";
    static public inline var BOWMAN:String = "bowman";
    static public inline var ELF:String = "elf";
    static public inline var MAGE:String = "mage";
    static public inline var HORSEMAN:String = "horseman";
    static public inline var ASSASSIN:String = "assassin";
}

class ControlType {
    static public inline var MOUSE:String = "mouse";
    static public inline var ARROWS:String = "keys_arrows";
    static public inline var AWSD:String = "keys_awsd";
    static public inline var BOT_SIMPLE:String = "bot_simple";
    static public inline var BOT_HARD:String = "bot_hard";
    static public inline var NONE:String = "none";
}

typedef MovingObjectState = {
    var charType:String;
    var x:Int;
    var y:Int;
    var label:String;
    var id:String;
    var control:String;
    var skin:Int;
}

typedef PlayerData = {
    var classId:String;
    var slayedCounter:Int;
    var expGained:Float;
    var currentLevel:Int;
    var label:String;
    var control:String;
    var teamId:Int;
}

typedef MobData = {
    var currentLevel:Int;
}

typedef GameConfiguration = {
    var showLabel:Bool;
    var baseExpGain:Float;
    var mobAmount:Int;
    var teamMode:Bool;
}