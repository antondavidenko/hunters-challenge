package model;

import model.DataTypes.GameConfiguration;

typedef AbstractCharacterAssetsConfig = {
    var frameSize:Int;
    var skins:Int;
    var assetsList:Array<AssetConfig>;
}

typedef AssetConfig = {
    var id:String;
    var url:String;
}

typedef MovingObjectConfig = {
    var MIN_DISTANCE:Int;
    var IDLE_POSE_ID:Int;
    var COLISION_ANIM_ID:Int;
    var deffaultPosition:Int;
    var positionsSetup:Array<PositionRange>;
}

typedef PositionRange = {
    var from:Int;
    var to:Int;
    var result:Int;
}

typedef MainMenuConfig = {
    var spawnPoints:Array<String>;
    var lobbyPvpSlots:Array<SlotConfig>;
    var lobbyPveSlots:Array<SlotConfig>;
    var lobbyTeamsSlots:Array<SlotConfig>;
    var defaultGameConfiguration:GameConfiguration;
}

typedef SlotConfig = {
    var slotNum:String;
    var charType:String;
    var control:String;
    var spawnPointId:String;
    var skin:String;
}