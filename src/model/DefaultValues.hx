package model;

import model.PhaserGameModel.ControlType;
import model.PhaserGameModel.CharType;

class DefaultValues {
    static public var slots:Array<Slot> = [];
    static public var mobAmount:Int = 5;
    static public var maxLvl:Int = 5;
    static public var baseExpGain:Float = 25;
    static public var screenMode:String = "";
    static public var showLabel:Bool = true;

    static public function init():Void {
        slots.push(new Slot("Player 1", CharType.HORSEMAN, ControlType.MOUSE, 400, 300));
        slots.push(new Slot("bot 1", CharType.SWORDMAN, ControlType.BOT_SIMPLE, 200, 300));
        slots.push(new Slot("bot 2", CharType.SWORDMAN, ControlType.BOT_SIMPLE, 300, 300));
        slots.push(new Slot("bot 3", CharType.SWORDMAN, ControlType.BOT_SIMPLE, 500, 300));
        slots.push(new Slot("bot 4", CharType.SWORDMAN, ControlType.BOT_SIMPLE, 600, 300));
        slots.push(new Slot("bot 5", CharType.SWORDMAN, ControlType.BOT_SIMPLE, 700, 300));
    }
}

class Slot {
    public function new(name:String, charType:String, controlType:String, x:Int, y:Int) {
        this.name = name;
        this.controlType = controlType;
        this.charType = charType;
        this.x = x;
        this.y = y;
    }

    public var name:String;
    public var charType:String;
    public var x:Int;
    public var y:Int;
    public var controlType:String;
}