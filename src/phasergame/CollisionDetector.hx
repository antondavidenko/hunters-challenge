package phasergame;

import phaser.gameobjects.Sprite;
import phasergame.sceneobjects.AbstractCharacter;

class CharackterAndMobData {

    public var charackter:String;
    public var mob:String;

    public function new(charackter:String, mob:String) {
        this.charackter = charackter;
        this.mob = mob;
    }
}

class CollisionDetector {

    private var allCharacktersList:Array<AbstractCharacter>;
    private var allMobList:Array<AbstractCharacter>;
    private var phaserScene:phaser.Scene;

    private var onCharackterAndMobCallback:CharackterAndMobData->Void;

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function init(allCharacktersList:Array<AbstractCharacter>, allMobList:Array<AbstractCharacter>) {
        this.allCharacktersList = allCharacktersList;
        this.allMobList = allMobList;
        initCollisionDetections();
    }

    public function onCharackterAndMob(callback:CharackterAndMobData->Void):Void {
        onCharackterAndMobCallback = callback;
    }

    private function initCollisionDetections():Void {
        for (charackter in allCharacktersList) {
            for (mob in allMobList) {
                var charackterBody:Sprite  = charackter.getPhysicBody();
                var mobBody:Sprite = mob.getPhysicBody();
                var collision = phaserScene.physics.add.overlap(charackterBody, mobBody, function (charackter:Sprite, mob:Sprite)
                {
                    onCharackterAndMobCallback(new CharackterAndMobData (charackter.name, mob.name));
                }, null, this);
            }
        }
    }
}