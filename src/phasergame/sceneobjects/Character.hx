package phasergame.sceneobjects;

import phaser.animations.types.GenerateFrameNumbers;
import model.PhaserGameModel.CharStartConfig;
import phaser.gameobjects.Text;
import model.Model;
//import phaser.GenerateFrameNumbersConfig;
import phaser.gameobjects.Sprite;

class Character {

    private var sprite:Sprite;
    private var phaserScene:phaser.Scene;
    private var config:CharStartConfig;
    private var text:Text;

    private var DEFAULT_POSE_ID:Int = Model.character.DEFAULT_POSE_ID;
    private var MOVE_SPEED:Int = Model.character.MOVE_SPEED;
    private var MIN_DISTANCE:Int = Model.character.MIN_DISTANCE;
    private var xDestination:Int;
    private var yDestination:Int;

    public function new(phaserScene:phaser.Scene, config:CharStartConfig) {
        this.phaserScene = phaserScene;
        this.config = config;
    }

    public function init():Void {
        for (i in 0...11) {
            var key:String = getIdByTypeIdAndLineId(config.charType, i);
            if (phaserScene.anims.get(key) == null) {
                phaserScene.anims.create(getAnimationConfig(config.charType, i));
            }
        }
        sprite = phaserScene.physics.add.sprite(config.x, config.y, config.charType).setScale(1.5);
        sprite.setSize(16, 16);
        sprite.body.offset.x = 8;
        sprite.body.offset.y = 8;
        sprite.name = config.name;
        sprite.depth = config.y;
        setAnimation(DEFAULT_POSE_ID);
        setLabel(config.label);
    }

    public function reinit(config:CharStartConfig):Void {
        this.config = config;
        for (i in 0...11) {
            var key:String = getIdByTypeIdAndLineId(config.charType, i);
            if (phaserScene.anims.get(key) == null) {
                phaserScene.anims.create(getAnimationConfig(config.charType, i));
            }
        }
        setAnimation(DEFAULT_POSE_ID);
        text.text = config.label;
        text.updateText();
    }

    public function setLabel(label:String):Void {
        text = phaserScene.add.text(sprite.x, sprite.y, label);
        text.visible = Model.showLabel;
        updateTextPosition();
    }

    public function setSpeed(speed:Int):Void {
        MOVE_SPEED = speed;
    }

    private function setAnimation(lineId:Int):Void {
        var animationId:String = getIdByTypeIdAndLineId(config.charType, lineId);
        if (sprite.anims.getCurrentKey() != animationId) {
            sprite.anims.load(animationId);
            sprite.anims.play(animationId);
        }
    }

    private function getIdByTypeIdAndLineId(typeId:String, lineId:Int):String {
        return 'typeId:' + typeId + "_lineId:" + lineId;
    }

    private function getAnimationConfig(typeId:String, lineId:Int):phaser.animations.types.Animation {
        var result:phaser.animations.types.Animation = {
            key: getIdByTypeIdAndLineId(typeId, lineId),
            frames: phaserScene.anims.generateFrameNumbers(typeId, getFrameConfigByLineId(lineId)),
            frameRate: 6,
            yoyo: true,
            repeat: -1
        };
        return result;
    }

    private function getFrameConfigByLineId(lineId:Int):GenerateFrameNumbers {
        lineId = (lineId - 1) * 4;
        return getFrameConfig(lineId, lineId + 3);
    }

    private function getFrameConfig(start:Int, end:Int):GenerateFrameNumbers {
        var result:GenerateFrameNumbers = {
            start:start,
            end:end
        }
        return result;
    }

    public function setGoToXY(x:Int, y:Int):Void {
        var tx:Float = x - sprite.x;
        var ty:Float = y - sprite.y;
        var dist:Float = Math.sqrt(tx * tx + ty * ty);
        var rad:Float = Math.atan2(ty, tx);
        var angle:Float = rad / Math.PI * 180;
        setAnimation(detectPosByAngle(angle));
        phaserScene.physics.moveTo(sprite, x, y, MOVE_SPEED);
        xDestination = x;
        yDestination = y;
    }

    public function setXY(x:Int, y:Int):Void {
        sprite.x = x;
        sprite.y = y;
    }

    private function detectPosByAngle(angle:Float):Int {
        var result:Int = 3;
        angle = angle + 180;

        if (angle <= 112 && angle >= 67) { result = 6; }
        if (angle <= 67 && angle >= 22) { result = 10; }
        if (angle <= 157 && angle >= 112) { result = 9; }
        if (angle <= 202 && angle >= 157) { result = 4; }
        if (angle <= 247 && angle >= 202) { result = 7; }
        if (angle <= 292 && angle >= 247) { result = 5; }
        if (angle <= 337 && angle >= 292) { result = 8; }
        return result;
    }

    public function update(time:Float, delta:Float):Void {
        checkDestinationReached();
        sprite.depth = sprite.y;
        updateTextPosition();
    }

    private function updateTextPosition() {
        text.x = sprite.x - text.width / 2;
        text.y = sprite.y - sprite.height * 1.35;
        text.depth = sprite.y + 1;
    }

    private function checkDestinationReached():Void {
        var distance:Float = Utils.distanceBetween(sprite.x, sprite.y, xDestination, yDestination);
        if (distance < MIN_DISTANCE) {
            sprite.body.velocity.x = 0;
            sprite.body.velocity.y = 0;
            sprite.x = xDestination;
            sprite.y = yDestination;
        }
    }

    public function getPhysicBody():Sprite {
        return sprite;
    }
}