package phasergame.sceneobjects;

import phasergame.api.PhaserGamePort;
import phasergame.model.DataTypes.ExpGainPoint;
import phasergame.model.PhaserGameModel;
import phasergame.model.DefaultValues;
import phaser.gameobjects.Text;

class TextLabelsCollection {

    private var phaserScene:phaser.Scene;
    private var countUpBig:Text;
    private var countUpSmall:Text;
    private var countUpCounter:Int = 0;
    private var countUpBigLabels:Array<String> = ["Ready", "Ready", "Steady", "GO!"];
    private var countUpSmallLabels:Array<String> = ["1", "2", "3", "GO!"];

    private var bigTextStyle:Dynamic = { fontFamily: "Arial Black", fontSize: 74, color: "#ccd8ff" };
    private var smallTextStyle:Dynamic = { fontFamily: "Arial Black", fontSize: 46, color: "#ccd8ff" };
    private var expTextStyle:Dynamic = { fontFamily: "Arial Black", fontSize: 15, color: "#ffffff" };

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
                PhaserGamePort.doCountUpProgress(countUpCounter);
            } else {
                timer.stop();
                countUpSmall.visible = false;
                countUpBig.visible = false;
                PhaserGamePort.doCountUpFinish();
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

    public function showGetExpMessage(expGainPoint:ExpGainPoint):Void {
        var text:Text = createExpText(expGainPoint.x, expGainPoint.y, expGainPoint.exp);
        var timer = new haxe.Timer(1000);
        timer.run = function() {
            text.destroy();
        }
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
        text.x = (DefaultValues.getGeneralConfig().phaserGameWidth - text.width) / 2;
    }

    private function createExpText(x:Int, y:Int, exp:Int):Text {
        var text:Text = phaserScene.add.text(x, y, Std.string(exp), expTextStyle);
        var finalY:Int = y - 24;
        text.setShadow(2, 2, "#333333", 2, true, true);
        text.depth = 100500;
        phaserScene.add.tween({
            targets: text,
            alpha: 0,
            y: finalY,
            ease: 'Expo.easeIn',
            duration: 1000
        });
        return text;
    }
}