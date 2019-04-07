package htmlcontrols.mainmenu.helppage;

import htmlcontrols.mainmenu.store.MainMenuActions;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;

class HelpPage extends ReactComponentOfProps<Int> {
    public function new(props:Int):Void
    {
        super(props);
    }

    public override function render():ReactElement
    {
        return jsx('<div className="helpPage">
        <h3>Game rules</h3>
        The game itself is all about hunters challenge. There are from 2 to 6 hunters take a part in a challenge. It is could be only one winner. When hunters hunt their prey they get experience points. When hunter got 100 or more experience points he got level up. All hunters start with level 1. First who reach level 5 is the winner. All prey got level. Hunter receives more experience for the high-level prey.
        <h3>Classes description</h3>
        <table><tbody>
        <tr>
        <td><img className="HORSEMAN"/></td>
        <td className="helpPageClassDescription"><b>HORSEMAN</b> : The brave and the bold horseman put a heavy metal armor on his mighty muscular body.</td>
        <td><img className="BOWMAN"/></td>
        <td className="helpPageClassDescription"><b>BOWMAN</b> : Sharp-eyed bowman like a hawks eye put all of his arrows in the exactly bull eye.</td>
        </tr>
        <tr>
        <td><img className="SWORDMAN"/></td>
        <td className="helpPageClassDescription"><b>SWORDMAN</b> : Fight master, quick-armed swordman is always ready for a quick fight.</td>
        <td><img className="MAGE"/></td>
        <td className="helpPageClassDescription"><b>MAGE</b> : A wise and smart mage can cast a spell,  put enchant and even bring charm.</td>
        </tr>
        <tr>
        <td><img className="ELF"/></td>
        <td className="helpPageClassDescription"><b>ELF</b> : Like a mystery the elf always has secrets and they will be hidden from others before it to late to stop it.</td>
        <td></td><td></td>
        </tr>
        </tbody></table>
        </div>');
    }
}