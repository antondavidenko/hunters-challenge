package phasergame.sceneobjects;

import phaser.physics.matter.Sprite;
import phaser.loader.filetypes.ImageFrameConfig;
import model.DefaultValues;

class LocationDetailsCollection {

    private var phaserScene:phaser.Scene;

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload():Void {
        var frameSize:Int = 32;
        var frmeConfig:ImageFrameConfig = {frameWidth:frameSize, frameHeight:frameSize};
        phaserScene.load.spritesheet(DefaultValues.objectsSmall, 'assets/objects_small.png', frmeConfig);
        phaserScene.load.spritesheet(DefaultValues.objectsTree, 'assets/objects_tree.png', frmeConfig);
    }

    public function init():Void {
        spawnSmallObjects();
        for (point in DefaultValues.forestPoints) {
            spawnForest(point[0], point[1]);
        }
    }

    private function spawnSmallObjects():Void {
        for (i in 0...DefaultValues.objectsSmallAmount) {
            var randomX:Int = Utils.getRandomScreenX();
            var randomY:Int = Utils.getRandomScreenY();
            var randomDecorId = Std.random(9);
            var sprite:Sprite = phaserScene.add.sprite(randomX, randomY, DefaultValues.objectsSmall, randomDecorId).setScale(1.25);
            sprite.depth = sprite.y;
        }
    }

    private function spawnForest(forestX:Int, forestY:Int):Void {
        var delta:Int = DefaultValues.objectsTreePositionRandomizer;
        for (i in 0...DefaultValues.objectsTreeAmount) {
            var spawnX:Int = forestX + Std.int(delta / 2 - Std.random(delta));
            var spawnY:Int = forestY + Std.int(delta / 2 - Std.random(delta));
            var sprite:Sprite = phaserScene.add.sprite(spawnX, spawnY, DefaultValues.objectsTree).setScale(1.75);
            sprite.depth = sprite.y;
        }
    }
}
