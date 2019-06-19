package model;

typedef AbstractCharacterAssetsConfig = {
    var frameSize:Int;
    var skins:Int;
    var assetsList:Array<AssetConfig>;
}

typedef AssetConfig = {
    var id:String;
    var url:String;
}

typedef AbstractCharacterConfig = {
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