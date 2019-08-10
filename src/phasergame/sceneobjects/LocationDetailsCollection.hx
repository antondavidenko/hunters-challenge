package phasergame.sceneobjects;

import phasergame.model.ConfigTypes.AssetsConfig;
import phasergame.model.ConfigTypes.LocationConfig;
import phaser.physics.matter.Sprite;
import phaser.loader.filetypes.ImageFrameConfig;
import phasergame.model.DefaultValues;

class LocationDetailsCollection {

    private var phaserScene:phaser.Scene;
    private var config:LocationConfig;
    private var objectsSmallKey:String = "objects_small";
    private var objectsTreeKey:String = "objects_tree";

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
        config = DefaultValues.getLocationConfig();
    }

    public function preload():Void {
        var assetsConfig:AssetsConfig = DefaultValues.getLocationAssetsConfig();
        var frmeConfig:ImageFrameConfig = {frameWidth:assetsConfig.frameSize, frameHeight:assetsConfig.frameSize};
        for (asset in assetsConfig.assetsList) {
            phaserScene.load.spritesheet(asset.id, asset.url, frmeConfig);
        }
    }

    public function init():Void {
        spawnSmallObjects();
        for (point in config.forestPoints) {
            var points:Array<String> = point.split(",");
            spawnForest(Std.parseInt(points[0]), Std.parseInt(points[1]));
        }
    }

    private function spawnSmallObjects():Void {
        for (i in 0...config.objectsSmallAmount) {
            var randomX:Int = Utils.getRandomScreenX();
            var randomY:Int = Utils.getRandomScreenY();
            var randomDecorId = Std.random(9);
            var sprite:Sprite = phaserScene.add.sprite(randomX, randomY, objectsSmallKey, randomDecorId).setScale(1.25);
            sprite.depth = sprite.y;
        }
    }

    private function spawnForest(forestX:Int, forestY:Int):Void {
        var delta:Int = config.objectsTreePositionRandomizer;
        for (i in 0...config.objectsTreeAmount) {
            var spawnX:Int = forestX + Std.int(delta / 2 - Std.random(delta));
            var spawnY:Int = forestY + Std.int(delta / 2 - Std.random(delta));
            var sprite:Sprite = phaserScene.add.sprite(spawnX, spawnY, objectsTreeKey).setScale(1.75);
            sprite.depth = sprite.y;
        }
    }
}
