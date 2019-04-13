package model;

enum Page {
    PVP;
    PVE;
    TEAMS;
    HELP;
}

class Skin {
    static public inline var RED:Int = 1;
    static public inline var GREEN:Int = 2;
    static public inline var BLUE:Int = 3;
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

typedef CharacterConfig = {
    var MOVE_SPEED:Int;
    var MIN_DISTANCE:Int;
    var IDLE_POSE_ID:Int;
    var COLISION_ANIM_ID:Int;
}

typedef CharStartConfig = {
    var charType:String;
    var x:Int;
    var y:Int;
    var label:String;
    var name:String;
    var control:String;
    var skin:Int;
}

typedef PlayerData = {
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
    var slots:Array<CharStartConfig>;
    var screenMode:String;
    var showLabel:Bool;
    var baseExpGain:Float;
    var mobAmount:Int;
    var teamMode:Bool;
}