package phasergame;

import phasergame.CollisionDetector.CharackterAndMobData;
import htmlcontrols.SidePanelControl;
import model.Model;
import js.html.CanvasElement;
import phasergame.sceneobjects.CharacterController;
import phasergame.sceneobjects.MobController;
import phasergame.sceneobjects.Background;

class PhaserGame {
    private var scene:PhaserScene;
    private var game:phaser.Game;
    private var onGameEnd:Void->Void;

    public function new() {}

    public function init(gameCanvas:CanvasElement, sidePanelControl:SidePanelControl) {
        scene = new PhaserScene(sidePanelControl);
        scene.setCallbackOnGameEnd(onGameEndPhaserGame);
        game  = new phaser.Game({
            width: Model.phaserGameWidth,
            height: Model.phaserGameHeight,
            canvas: gameCanvas,
            scene: scene,
            physics: {"default": "arcade", "arcade": { "debug": false }},
        });
    }

    public function setCallbackOnGameEnd(callback:Void->Void):Void {
        onGameEnd = callback;
    }

    public function onGameEndPhaserGame():Void {
        onGameEnd();
    }
}

class PhaserScene extends phaser.Scene {

    private var background:Background;
    private var characterController:CharacterController;
    private var mobController:MobController;
    private var sidePanelControl:SidePanelControl;
    private var collisionDetector:CollisionDetector;
    private var onGameEnd:Void->Void;
    private var isPaused:Bool = false;

    public function new(sidePanelControl:SidePanelControl) {
        super();
        background = new Background(this);
        characterController = new CharacterController(this);
        mobController = new MobController(this);
        collisionDetector = new CollisionDetector(this);
        this.sidePanelControl = sidePanelControl;
    }

    public function setCallbackOnGameEnd(callback:Void->Void):Void {
        onGameEnd = callback;
    }

    public function preload() {
        background.preload();
        characterController.preload();
        mobController.preload();
    }

    public function create() {
        background.init();
        characterController.init();
        mobController.init();
        collisionDetector.init(characterController.getAllCharacktersList(), mobController.getAllMobList());
        collisionDetector.onCharackterAndMob(onCharackterAndMobCollision);
        this.input.on('pointerdown', function (pointer) {
            characterController.onPointerdown(pointer);
        }, this);
    }

    override public function update(time:Float, delta:Float):Void {
        if (!isPaused) {
            super.update(time, delta);
            characterController.update(time, delta);
            mobController.update(time, delta);
            sidePanelControl.update();
            checkGameEndCreteria();
        }
    }

    private function onCharackterAndMobCollision(dataNameId:CharackterAndMobData):Void {
        var mobLvl:Int = 1;//mobController.getLvlById(dataNameId.mob);
        characterController.onCharackterSlayMob(dataNameId.charackter, mobLvl);
        mobController.onMobSlayed(dataNameId.mob);
    }

    private function checkGameEndCreteria() {
        var isGameEnd:Bool = ((Model.charsData[0].currentLevel == Model.maxLvl)||
            (Model.charsData[1].currentLevel == Model.maxLvl)||
            (Model.charsData[2].currentLevel == Model.maxLvl)||
            (Model.charsData[3].currentLevel == Model.maxLvl)||
            (Model.charsData[4].currentLevel == Model.maxLvl)||
            (Model.charsData[5].currentLevel == Model.maxLvl));

        if (isGameEnd) {
            onGameEnd();
            this.physics.pause();
            isPaused = true;
        }
    }
}