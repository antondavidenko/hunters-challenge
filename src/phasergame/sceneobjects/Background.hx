package phasergame.sceneobjects;

import phaser.tilemaps.StaticTilemapLayer;
import phaser.tilemaps.Tileset;
import phaser.tilemaps.Tilemap;

class Background {

    private var tilesetName:String;
    private var phaserScene:phaser.Scene;

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
        tilesetName = 'tiles';
    }

    public function preload() {
        phaserScene.load.image(tilesetName, 'assets/tiles.png');
    }

    public function init():Void {
        var dynamicMap:Array<Array<Int>> = [for (x in 0...22) [for (y in 0...31) Std.random(8)]];
        var map:Tilemap = phaserScene.add.tilemap("dynamicMap", 16, 16, 0, 0, dynamicMap);
        var tiles:Tileset = map.addTilesetImage(tilesetName);
        var layer:StaticTilemapLayer = map.createStaticLayer(0, tiles, 0, 0);
        layer.scaleX = 2;
        layer.scaleY = 2;
    }
}
