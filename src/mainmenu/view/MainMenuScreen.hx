package mainmenu.view;

import mainmenu.model.DataTypes.RootState;
import mainmenu.model.DataTypes.MainMenuState;
import mainmenu.model.DataTypes.Page;
import mainmenu.model.Lobby;
import mainmenu.view.pages.LobbyView;
import react.ReactComponent;
import redux.react.IConnectedComponent;
import react.ReactMacro.jsx;

class MainMenuScreen extends ReactComponentOfPropsAndState<Dynamic, Dynamic> implements IConnectedComponent
{
    public function new(props:Dynamic) {
        super(props);
    }

    function mapState(state:RootState, props:Dynamic):Dynamic {
        return {
            list: state.mainMenuState.entries,
            page: state.mainMenuState.page
        }
    }

    override public function render():ReactElement
    {
        return jsx('<div className="containerLogin" id="loginPanel">
            <img src="./assets/logo.png" className="center" />
            <table><tbody><tr>
            <td className="valignTop">
                <h2>GAME MODES</h2>
                <GameModes {...state} dispatch=$dispatch />
                <h2>OPTIONS</h2>
                <GameOptions />
            </td><td className="mainMenuGap">
            </td><td className="valignTop">
                <LobbyView {...state} />
            </td>
            </tr></tbody></table>
        </div>');
    }
}