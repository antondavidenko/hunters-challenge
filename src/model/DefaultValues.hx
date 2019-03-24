package model;

import model.PhaserGameModel.ControlType;
import model.PhaserGameModel.PlayerType;

class DefaultValues {
    static public var slotsPVP:Array<Slot> = [];
    static public var slotsPVE:Array<Slot> = [];
    static public var slots:Array<Slot> = [];
    static public var mobAmount:Int = 5;
    static public var maxLvl:Int = 5;
    static public var baseExpGain:Float = 25;
    static public var screenMode:String = "";
    static public var showLabel:Bool = true;

    static public function init():Void {
        slotsPVE.push(new Slot("Player 1", PlayerType.HORSEMAN, ControlType.MOUSE, 400, 300, "p1"));
        slotsPVE.push(new Slot("bot 1", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 200, 300, "p2"));
        slotsPVE.push(new Slot("bot 2", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 300, 300, "p3"));
        slotsPVE.push(new Slot("bot 3", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 500, 300, "p4"));
        slotsPVE.push(new Slot("bot 4", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 600, 300, "p5"));
        slotsPVE.push(new Slot("bot 5", PlayerType.SWORDMAN, ControlType.BOT_SIMPLE, 700, 300, "p6"));

        slotsPVP.push(new Slot("Player 1", PlayerType.HORSEMAN, ControlType.MOUSE, 400, 300, "p1"));
        slotsPVP.push(new Slot("Player 2", PlayerType.BOWMAN, ControlType.ARROWS, 500, 300, "p2"));
        slotsPVP.push(new Slot("Player 3", PlayerType.MAGE, ControlType.AWSD, 600, 300, "p3"));
    }
}

class Slot {
    public function new(label:String, charType:String, controlType:String, x:Int, y:Int, name:String) {
        this.name = name;
        this.controlType = controlType;
        this.charType = charType;
        this.x = x;
        this.y = y;
        this.label = label;
    }

    public var name:String;
    public var charType:String;
    public var x:Int;
    public var y:Int;
    public var controlType:String;
    public var label:String;
}