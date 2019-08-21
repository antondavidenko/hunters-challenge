package phasergame.model;

typedef GeneralConfig = {
    var phaserGameWidth:Int;
    var phaserGameHeight:Int;
}

typedef AssetsConfig = {
    var frameSize:Int;
    var skins:Int;
    var assetsList:Array<AssetItem>;
}

typedef AssetItem = {
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

typedef SlotConfig = {
    var slotNum:String;
    var charType:String;
    var control:String;
    var spawnPointId:String;
    var skin:String;
}

typedef LocationConfig = {
    var objectsSmallAmount:Int;
    var objectsTreeAmount:Int;
    var objectsTreePositionRandomizer:Int;
    var forestPoints:Array<String>;
}

typedef GameplayConfig = {
    var mobSpeeds:Array<Int>;
    var playersSpeed:Int;
    var maxMobLvlId:Int;
    var mobTimeoutDelay:Int;
    var botSimpleTimeoutDelay:Int;
    var botHardTimeoutDelay:Int;
    var maxLvl:Int;
    var spawnPoints:Array<String>;
}