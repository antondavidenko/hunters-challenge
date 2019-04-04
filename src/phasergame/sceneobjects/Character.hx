package phasergame.sceneobjects;

import phaser.animations.types.GenerateFrameNumbers;
import model.PhaserGameModel.CharStartConfig;
import phaser.gameobjects.Text;
import model.Model;
import phaser.gameobjects.Sprite;

class Character {

    private var sprite:Sprite;
    private var phaserScene:phaser.Scene;
    private var config:CharStartConfig;
    private var text:Text;

    private var IDLE_POSE_ID:Int = 1;
    private var COLISION_ANIM_ID:Int = 2;
    private var MOVE_SPEED:Int = Model.character.MOVE_SPEED;
    private var MIN_DISTANCE:Int = Model.character.MIN_DISTANCE;
    private var xDestination:Int;
    private var yDestination:Int;
    private var onCollision:Bool = false;

    public function new(phaserScene:phaser.Scene, config:CharStartConfig) {
        this.phaserScene = phaserScene;
        this.config = config;
    }

    public function init():Void {
        for (i in 1...11) {
            var key:String = getIdByLine(i);
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
        setAnimation(IDLE_POSE_ID);
        setLabel(config.label);
    }

    public function reinit(config:CharStartConfig):Void {
        this.config = config;
        for (i in 1...11) {
            var key:String = getIdByLine(i);
            if (phaserScene.anims.get(key) == null) {
                phaserScene.anims.create(getAnimationConfig(config.charType, i));
            }
        }
        setAnimation(IDLE_POSE_ID);
        text.text = config.label;
        text.updateText();
    }

    public function setCollisionState(animComplete):Void {
        if (!onCollision) {
            onCollision = true;
            phaserScene.physics.moveTo(sprite, sprite.x, sprite.y, 0);
            setAnimation(COLISION_ANIM_ID, function() {
                onCollision = false;
                animComplete(this);
                sprite.off('animationcomplete');
            });
        }
    }

    public function setIdle():Void {
        setAnimation(IDLE_POSE_ID);
    }

    public function isOnCollision():Bool {
        return onCollision;
    }

    public function setLabel(label:String):Void {
        text = phaserScene.add.text(sprite.x, sprite.y, label);
        text.visible = Model.showLabel;
        updateTextPosition();
    }

    public function setSpeed(speed:Int):Void {
        MOVE_SPEED = speed;
    }

    private function setAnimation(lineId:Int, ?animComplete:Void -> Void):Void {
        var animationId:String = getIdByLine(lineId);
        if (sprite.anims.getCurrentKey() != animationId) {
            sprite.anims.load(animationId);
            if (animComplete != null) {
                sprite.on('animationcomplete', animComplete);
                sprite.anims.stopOnRepeat();
            }
            sprite.anims.play(animationId);
        }
    }

    private function getIdByLine(lineId:Int):String {
        return 'typeId:${config.charType}}_lineId:${lineId}_skin:${config.skin}';
    }

    private function getAnimationConfig(typeId:String, lineId:Int):phaser.animations.types.Animation {
        var result:phaser.animations.types.Animation = {
            key: getIdByLine(lineId),
            frames: phaserScene.anims.generateFrameNumbers(typeId, getFrameConfigByLineId(lineId)),
            frameRate: 6,
            yoyo: false,
            repeat: -1
        };
        return result;
    }

    private function getFrameConfigByLineId(lineId:Int):GenerateFrameNumbers {
        var maxSkins:Int = Model.skinsCollection[config.charType];
        lineId = (lineId - 1) * 4 + 4 * (maxSkins - 1) * (lineId - 1) + 4 * (config.skin - 1);
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
        if (!onCollision) {
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
            setAnimation(IDLE_POSE_ID);
        }
    }

    public function getPhysicBody():Sprite {
        return sprite;
    }
}