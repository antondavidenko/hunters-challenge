package phasergame;

import phasergame.PublicAPI.PhaserGameSignals;
import phasergame.sceneobjects.LocationDetailsCollection;
import phasergame.sceneobjects.TextLabelsCollection;
import phasergame.model.DefaultValues;
import phasergame.CollisionDetector.CharackterAndMobData;
import sidepanel.SidePanelControl;
import phasergame.model.PhaserGameModel;
import js.html.CanvasElement;
import phasergame.sceneobjects.PlayersCollection;
import phasergame.sceneobjects.MobsCollection;
import phasergame.sceneobjects.Background;

class PhaserGame {
    private var scene:PhaserScene;
    private var game:phaser.Game;
    private var gameCanvas:CanvasElement;

    public function new() {
        gameCanvas = cast js.Browser.document.getElementById("gameCanvas");
    }

    public function init(sidePanelControl:SidePanelControl) {
        scene = new PhaserScene(sidePanelControl);
        game = new phaser.Game({
            width: DefaultValues.getGeneralConfig().phaserGameWidth,
            height: DefaultValues.getGeneralConfig().phaserGameHeight,
            canvas: gameCanvas,
            scene: scene,
            physics: {"default": "arcade", "arcade": { "debug": false }},
        });
    }

    public function onResize(windowWidth:Int, windowHeight:Int, multiplayer:Float):Void {
        gameCanvas.style.height = Std.int(DefaultValues.getGeneralConfig().phaserGameHeight * multiplayer) + 'px';
        gameCanvas.style.width = Std.int(DefaultValues.getGeneralConfig().phaserGameWidth * multiplayer) + 'px';
        gameCanvas.style.position = 'absolute';
        gameCanvas.style.left = (windowWidth - DefaultValues.getGeneralConfig().phaserGameWidth * multiplayer) + 'px';
        gameCanvas.style.top = ((windowHeight - DefaultValues.getGeneralConfig().phaserGameHeight * multiplayer) / 2) + 'px';
    }

    public function show():Void {
        gameCanvas.style.display = "block";
    }
}

class PhaserScene extends phaser.Scene {

    private var background:Background;
    private var playersCollection:PlayersCollection;
    private var mobsCollection:MobsCollection;
    private var textLabelsCollection:TextLabelsCollection;
    private var locationDetailsCollection:LocationDetailsCollection;

    private var sidePanelControl:SidePanelControl;
    private var collisionDetector:CollisionDetector;
    private var moverCharacters:DirectionDefiner;

    private var isPaused:Bool = false;

    public function new(sidePanelControl:SidePanelControl) {
        super({});
        background = new Background(this);
        playersCollection = new PlayersCollection(this);
        mobsCollection = new MobsCollection(this);
        textLabelsCollection = new TextLabelsCollection(this);
        locationDetailsCollection = new LocationDetailsCollection(this);
        collisionDetector = new CollisionDetector(this);
        moverCharacters = new DirectionDefiner();
        this.sidePanelControl = sidePanelControl;
        PhaserGameSignals.countUpFinish.add(onGameStart);
    }

    public function preload() {
        background.preload();
        playersCollection.preload();
        mobsCollection.preload();
        locationDetailsCollection.preload();
    }

    public function create() {
        background.init();
        mobsCollection.init(moverCharacters.initMobs);
        playersCollection.init(moverCharacters.initPlayers);
        locationDetailsCollection.init();
        collisionDetector.init(playersCollection.getAllPlayersList(), mobsCollection.getAllMobList());
        collisionDetector.onCharackterAndMob(onCharackterAndMobCollision);
        this.input.on('pointerdown', function(pointer) {
            moverCharacters.onPointerdown(pointer);
        }, this);
        this.input.on('pointerup', function(pointer) {
            moverCharacters.onPointerup(pointer);
        }, this);
        this.input.on('pointermove', function(pointer) {
            moverCharacters.onPointermove(pointer);
        }, this);
        moverCharacters.setKeys(this.input.keyboard.addKeys('A,W,S,D'));
        moverCharacters.setCursor(this.input.keyboard.createCursorKeys());
        textLabelsCollection.showCountUpMessage();
        this.physics.pause();
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

    private function onCharackterAndMobCollision(collisionMembers:CharackterAndMobData):Void {
        if (mobsCollection.onMobCollision(collisionMembers.mob)) {
            var mobLvl:Int = PhaserGameModel.mobsData[collisionMembers.mob].currentLevel;
            PhaserGameSignals.mobSlayed.dispatch(mobLvl);
            playersCollection.onPlayerSlayMob(collisionMembers.charackter, mobLvl);
        }
    }

    private function checkGameEndCreteria() {
        var isGameEnd:Bool = PhaserGameModel.maxLvlInGame == PhaserGameModel.maxLvl;

        if (isGameEnd) {
            PhaserGameSignals.gameEnd.dispatch();
            textLabelsCollection.showEndGameMessage();
            this.physics.pause();
            moverCharacters.setPause(true);
            playersCollection.stopAll();
            mobsCollection.stopAll();
            isPaused = true;
        }
    }

    private function onGameStart() {
        this.physics.resume();
    }
}