package phasergame.sceneobjects;

import model.PhaserGameModel;
import model.DefaultValues;
import phaser.gameobjects.Text;

class TextLabelsCollection {

    private var phaserScene:phaser.Scene;

    public function new(phaserScene:phaser.Scene) {
        this.phaserScene = phaserScene;
    }

    public function showEndGameMessage():Void {
        var header:Text = phaserScene.add.text(100, 210, "Challenge is over", { fontFamily: "Arial Black", fontSize: 74, color: "#ccd8ff" });
        header.setStroke('#8ca7f7', 16);
        header.setShadow(2, 2, "#333333", 2, true, true);
        header.depth = 100500;
        header.x = (DefaultValues.phaserGameWidth - header.width) / 2;

        var info:Text = phaserScene.add.text(120, 310, 'winner is: ${PhaserGameModel.leaderPlayerLabel}', { fontFamily: "Arial Black", fontSize: 46, color: "#ccd8ff" });
        info.setShadow(2, 2, "#333333", 2, true, true);
        info.depth = 100500;
        info.x = (DefaultValues.phaserGameWidth - info.width) / 2;
    }
}
