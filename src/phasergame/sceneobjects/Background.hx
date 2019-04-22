package phasergame.sceneobjects;

import phaser.tilemaps.StaticTilemapLayer;
import phaser.tilemaps.Tileset;
import phaser.tilemaps.Tilemap;

class Background {

    static private inline var tilesetName:String = 'tiles';
    static private inline var tiledecorsetName:String = 'tiles_decor';
    private var phaserScene:phaser.Scene;

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function preload() {
        phaserScene.load.image(tilesetName, 'assets/tiles.png');
        phaserScene.load.image(tiledecorsetName, 'assets/tiles_decor.png');
    }

    public function init():Void {
        createTilesLayer(9, tilesetName);
        createTilesLayer(9*10, tiledecorsetName);
    }

    private function createTilesLayer(randomMax:Int, tileset:String):Void {
        var dynamicMap:Array<Array<Int>> = [for (x in 0...22) [for (y in 0...31) Std.random(randomMax)]];
        var map:Tilemap = phaserScene.add.tilemap("dynamicMap", 32, 32, 0, 0, dynamicMap);
        var tiles:Tileset = map.addTilesetImage(tileset);
        var layer:StaticTilemapLayer = map.createStaticLayer(0, tiles, 0, 0);
    }
}