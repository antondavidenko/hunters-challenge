package model;

import model.DataTypes.GameConfiguration;

typedef GeneralConfig = {
    var localizationFile:String;
    var phaserGameWidth:Int;
    var phaserGameHeight:Int;
    var maxLvl:Int;
}

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
    var maxMainMenuSize:String;
    var spawnPoints:Array<String>;
    var pvpGameConfiguration:Array<SlotConfig>;
    var pveGameConfiguration:Array<SlotConfig>;
    var teamsGameConfiguration:Array<SlotConfig>;
    var defaultGameConfiguration:GameConfiguration;
}

typedef SlotConfig = {
    var slotNum:String;
    var charType:String;
    var control:String;
    var spawnPointId:String;
    var skin:String;
}

typedef LocationConfig = {
    var objectsSmallKey:String;
    var objectsSmallAssets:String;
    var objectsTreeKey:String;
    var objectsTreeAssets:String;
    var objectsSmallAmount:Int;
    var objectsTreeAmount:Int;
    var objectsTreePositionRandomizer:Int;
    var forestPoints:Array<String>;
}