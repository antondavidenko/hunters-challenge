package phasergame.sceneobjects;

import phasergame.PhaserGame.PhaserGameActions;
import model.PhaserGameModel;
import model.DefaultValues;
import phaser.gameobjects.Text;

class TextLabelsCollection {

    private var phaserScene:phaser.Scene;
    private var countUpBig:Text;
    private var countUpSmall:Text;
    private var countUpCounter:Int = 0;
    private var countUpBigLabels:Array<String> = ["Ready","Ready","Steady","GO!"];
    private var countUpSmallLabels:Array<String> = ["1","2","3","GO!"];

    private var bigTextStyle:Dynamic = { fontFamily: "Arial Black", fontSize: 74, color: "#ccd8ff" };
    private var smallTextStyle:Dynamic = { fontFamily: "Arial Black", fontSize: 46, color: "#ccd8ff" };

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function showCountUpMessage():Void {
        var countUpBig:Text = createText(100, 110, bigTextStyle);
        countUpBig.setStroke('#8ca7f7', 16);

        var countUpSmall:Text = createText(120, 210, smallTextStyle);

        var timer = new haxe.Timer(1000);
        timer.run = function() {
            if (countUpSmallLabels[countUpCounter] != null) {
                setTextLabel(countUpSmall, countUpSmallLabels[countUpCounter]);
                setTextLabel(countUpBig, countUpBigLabels[countUpCounter]);
                PhaserGameActions.countUpProgress.dispatch(countUpCounter);
            } else {
                timer.stop();
                countUpSmall.visible = false;
                countUpBig.visible = false;
                PhaserGameActions.countUpFinish.dispatch();
            }
            countUpCounter++;
        }
    }

    public function showEndGameMessage():Void {
        var header:Text = createText(100, 210, bigTextStyle);
        header.setStroke('#8ca7f7', 16);
        setTextLabel(header, "Challenge is over");

        var info:Text = createText(120, 310, smallTextStyle);
        setTextLabel(info, 'winner is: ${PhaserGameModel.leaderPlayerLabel}');
    }

    private function createText(x:Float, y:Float, style:Dynamic):Text {
        var text:Text = phaserScene.add.text(x, y, "", style);
        text.setShadow(2, 2, "#333333", 2, true, true);
        text.depth = 100500;
        return text;
    }

    private function setTextLabel(text:Text, label:String):Void {
        text.text = label;
        text.updateText();
        text.x = (DefaultValues.phaserGameWidth - text.width) / 2;
    }
}