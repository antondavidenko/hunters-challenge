package model;

import model.PhaserGameModel.CharData;
import model.PhaserGameModel.CharacterConfig;
import model.PhaserGameModel.CharStartConfig;

class Model {
    static public var phaserGameWidth:Int = 950;
    static public var phaserGameHeight:Int = 654;

    static public var botTimeoutDelay:Int = 1000;
    static public var mobTimeoutDelay:Int = 100;

    static public var character:CharacterConfig = new CharacterConfig();
    static public var charsStartConfig:Array<CharStartConfig> = [];

    static public var mobAmount:Int;
    static public var maxLvl:Int;
    static public var baseExpGain:Float;
    static public var screenMode:String;
    static public var showLabel:Bool;

    static public var totalMobSlayedCounter = 0;
    static public var charsData:Array<CharData> = [];

    static public var playerId:String = "";
    static public var botsId:Array<String> = [];

    static public function init():Void {
        character.DEFAULT_POSE_ID = 7;
        character.MOVE_SPEED = 150;
        character.MIN_DISTANCE = 3;

        mobAmount = DefaultValues.mobAmount;
        maxLvl = DefaultValues.maxLvl;
        baseExpGain = DefaultValues.baseExpGain;
        screenMode = DefaultValues.screenMode;
        showLabel = DefaultValues.showLabel;

        for (i in 0...6) {
            charsData.push(new CharData(0,0,1));
            charsStartConfig.push(getCharStartConfigByDefaultValues(i));
        }
    }

    static private function getCharStartConfigByDefaultValues(id:Int):CharStartConfig {
        var charType:String = DefaultValues.slots[id].charType;
        var name:String = DefaultValues.slots[id].name;
        var x:Int = DefaultValues.slots[id].x;
        var y:Int = DefaultValues.slots[id].y;
        return new CharStartConfig(charType,x,y,name);
    }
}