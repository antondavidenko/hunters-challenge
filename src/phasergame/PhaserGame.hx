package phasergame;

import phasergame.CollisionDetector.CharackterAndMobData;
import htmlcontrols.SidePanelControl;
import model.Model;
import js.html.CanvasElement;
import phasergame.sceneobjects.PlayersCollection;
import phasergame.sceneobjects.MobsCollection;
import phasergame.sceneobjects.Background;

class PhaserGame {
    private var scene:PhaserScene;
    private var game:phaser.Game;
    private var onGameEnd:Void -> Void;

    public function new() {}

    public function init(gameCanvas:CanvasElement, sidePanelControl:SidePanelControl) {
        scene = new PhaserScene(sidePanelControl);
        scene.setCallbackOnGameEnd(onGameEndPhaserGame);
        game = new phaser.Game({
            width: Model.phaserGameWidth,
            height: Model.phaserGameHeight,
            canvas: gameCanvas,
            scene: scene,
            physics: {"default": "arcade", "arcade": { "debug": false }},
        });
    }

    public function setCallbackOnGameEnd(callback:Void -> Void):Void {
        onGameEnd = callback;
    }

    public function onGameEndPhaserGame():Void {
        onGameEnd();
    }
}

class PhaserScene extends phaser.Scene {

    private var background:Background;
    private var playersCollection:PlayersCollection;
    private var mobsCollection:MobsCollection;

    private var sidePanelControl:SidePanelControl;
    private var collisionDetector:CollisionDetector;
    private var moverCharacters:MoverCharacters;

    private var onGameEnd:Void -> Void;
    private var isPaused:Bool = false;

    public function new(sidePanelControl:SidePanelControl) {
        super();
        background = new Background(this);
        playersCollection = new PlayersCollection(this);
        mobsCollection = new MobsCollection(this);
        collisionDetector = new CollisionDetector(this);
        moverCharacters = new MoverCharacters();
        this.sidePanelControl = sidePanelControl;
    }

    public function setCallbackOnGameEnd(callback:Void -> Void):Void {
        onGameEnd = callback;
    }

    public function preload() {
        background.preload();
        playersCollection.preload();
        mobsCollection.preload();
    }

    public function create() {
        background.init();
        playersCollection.init(moverCharacters.initPlayers);
        mobsCollection.init(moverCharacters.initMobs);
        collisionDetector.init(playersCollection.getAllPlayersList(), mobsCollection.getAllMobList());
        collisionDetector.onCharackterAndMob(onCharackterAndMobCollision);
        this.input.on('pointerdown', function(pointer) {
            moverCharacters.onPointerdown(pointer);
        }, this);
        moverCharacters.setKeys(this.input.keyboard.addKeys('A,W,S,D'));
        moverCharacters.setCursor(this.input.keyboard.createCursorKeys());

    }

    override public function update(time:Float, delta:Float):Void {
        if (!isPaused) {
            super.update(time, delta);
            moverCharacters.update();
            playersCollection.update(time, delta);
            mobsCollection.update(time, delta);
            sidePanelControl.update();
            checkGameEndCreteria();
        }
    }

    private function onCharackterAndMobCollision(dataNameId:CharackterAndMobData):Void {
        var mobLvl:Int = Model.mobsData[dataNameId.mob].currentLevel;
        playersCollection.onPlayerSlayMob(dataNameId.charackter, mobLvl);
        mobsCollection.onMobSlayed(dataNameId.mob);
    }

    private function checkGameEndCreteria() {
        var isGameEnd:Bool = Model.maxLvlInGame == Model.maxLvl;

        if (isGameEnd) {
            onGameEnd();
            this.physics.pause();
            isPaused = true;
        }
    }
}