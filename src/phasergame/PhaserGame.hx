package phasergame;

import msignal.Signal.Signal0;
import model.DefaultValues;
import phaser.gameobjects.Text;
import phasergame.CollisionDetector.CharackterAndMobData;
import htmlcontrols.SidePanelControl;
import model.PhaserGameModel;
import js.html.CanvasElement;
import phasergame.sceneobjects.PlayersCollection;
import phasergame.sceneobjects.MobsCollection;
import phasergame.sceneobjects.Background;

class PhaserGameActions
{
    public static var gameEnd:Signal0 = new Signal0();
    public static var mobSlayed:Signal0 = new Signal0();
}

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
            width: DefaultValues.phaserGameWidth,
            height: DefaultValues.phaserGameHeight,
            canvas: gameCanvas,
            scene: scene,
            physics: {"default": "arcade", "arcade": { "debug": false }},
        });
    }

    public function onResize(windowWidth:Int, windowHeight:Int, multiplayer:Float):Void {
        gameCanvas.style.height = Std.int(DefaultValues.phaserGameHeight * multiplayer) + 'px';
        gameCanvas.style.width = Std.int(DefaultValues.phaserGameWidth * multiplayer) + 'px';
        gameCanvas.style.position = 'absolute';
        gameCanvas.style.left = (windowWidth - DefaultValues.phaserGameWidth * multiplayer) + 'px';
        gameCanvas.style.top = ((windowHeight - DefaultValues.phaserGameHeight * multiplayer) / 2) + 'px';
    }

    public function show():Void {
        gameCanvas.style.display = "block";
    }
}

class PhaserScene extends phaser.Scene {

    private var background:Background;
    private var playersCollection:PlayersCollection;
    private var mobsCollection:MobsCollection;

    private var sidePanelControl:SidePanelControl;
    private var collisionDetector:CollisionDetector;
    private var moverCharacters:MoverCharacters;

    private var isPaused:Bool = false;

    public function new(sidePanelControl:SidePanelControl) {
        super({});
        background = new Background(this);
        playersCollection = new PlayersCollection(this);
        mobsCollection = new MobsCollection(this);
        collisionDetector = new CollisionDetector(this);
        moverCharacters = new MoverCharacters();
        this.sidePanelControl = sidePanelControl;
    }

    public function preload() {
        background.preload();
        playersCollection.preload();
        mobsCollection.preload();
    }

    public function create() {
        background.init();
        mobsCollection.init(moverCharacters.initMobs);
        playersCollection.init(moverCharacters.initPlayers);
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
        if (mobsCollection.onMobCollision(dataNameId.mob)) {
            PhaserGameActions.mobSlayed.dispatch();
            var mobLvl:Int = PhaserGameModel.mobsData[dataNameId.mob].currentLevel;
            playersCollection.onPlayerSlayMob(dataNameId.charackter, mobLvl);
        }
    }

    private function checkGameEndCreteria() {
        var isGameEnd:Bool = PhaserGameModel.maxLvlInGame == PhaserGameModel.maxLvl;

        if (isGameEnd) {
            PhaserGameActions.gameEnd.dispatch();
            showEndGameMessage();
            this.physics.pause();
            moverCharacters.setPause(true);
            playersCollection.stopAll();
            mobsCollection.stopAll();
            isPaused = true;
        }
    }

    private function showEndGameMessage():Void {
        var header:Text = this.add.text(100, 210, "Challenge is over", { fontFamily: "Arial Black", fontSize: 74, color: "#ccd8ff" });
        header.setStroke('#8ca7f7', 16);
        header.setShadow(2, 2, "#333333", 2, true, true);
        header.depth = 100500;
        header.x = (DefaultValues.phaserGameWidth - header.width)/2;

        var info:Text = this.add.text(120, 310, 'winner is: ${PhaserGameModel.leaderPlayerLabel}', { fontFamily: "Arial Black", fontSize: 46, color: "#ccd8ff" });
        info.setShadow(2, 2, "#333333", 2, true, true);
        info.depth = 100500;
        info.x = (DefaultValues.phaserGameWidth - info.width)/2;
    }
}