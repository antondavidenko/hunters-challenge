package htmlcontrols.mainmenu;

import model.DataTypes.GameConfiguration;
import model.DataTypes.Page;
import react.ReactComponent.ReactElement;
import react.ReactComponent.ReactComponentOfProps;
import react.ReactMacro.jsx;
import htmlcontrols.mainmenu.lobby.LobbyPanel;
import htmlcontrols.mainmenu.helppage.HelpPage;
import msignal.Signal.Signal1;

class MainMenuActions
{
    public static var navigateToPage:Signal1<Page> = new Signal1();
    public static var startGame:Signal1<Page> = new Signal1();
}

typedef MainMenuProps = {
    var data:Map<Page, GameConfiguration>;
    var page:Page;
}

class MainMenu extends ReactComponentOfProps<MainMenuProps> {

    public function new(props:MainMenuProps):Void
    {
        super(props);
        state = {page:props.page, configuration:props.data[props.page]}
        MainMenuActions.navigateToPage.add(navigateToPage);
    }

    function navigateToPage(page:Page):Void
    {
        setState({page:page, configuration:props.data[page]});
    }

    public override function render():ReactElement
    {
        return jsx('<table><tbody><tr>
        <td className="valignTop">
            <h2>MAIN MENU</h2>
            <GameModes page="${props.page}"></GameModes>
        </td><td className="mainMenuGap">
        </td><td className="valignTop">
            {this.getOptionsByState()}
            {this.getContentByState()}
        </td>
        </tr></tbody></table>');
    }

    function getOptionsByState():ReactElement
    {
        if (state.page == Page.PVP || state.page == Page.PVE || state.page == Page.TEAMS) {
            return jsx('<div>
            <h2>GAME-PLAY OPTIONS</h2>
            <GamePlayOptions data=${props.data} page=${state.page}></GamePlayOptions>
            </div>');
        } else {
            return jsx('<div></div>');
        }
    }

    function getContentByState():ReactElement
    {
        if (state.page == Page.PVP) {
            return jsx('<div>
            <h2>PVP LOBBY</h2>
            <LobbyPanel slots="${state.configuration.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onPVPClicked">PLAY</button>
            </div>');
        } else if (state.page == Page.PVE) {
            return jsx('<div>
            <h2>PVE LOBBY</h2>
            <LobbyPanel slots="${state.configuration.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onPVEClicked">PLAY</button>
            </div>');
        } else if (state.page == Page.TEAMS) {
            return jsx('<div>
            <h2>TEAMS LOBBY</h2>
            <LobbyPanel slots="${state.configuration.slots}"></LobbyPanel>
            <button id="loginButton" onClick="$onTEAMSClicked">PLAY</button>
            </div>');
        } else if (state.page == Page.HELP) {
            return jsx('<div>
            <h2>HELP</h2>
            <HelpPage></HelpPage>
            </div>');
        } else {
            return jsx('<div>404 page:${state.page} is not found</div>');
        }
    }

    function onPVPClicked(evt:js.html.Event):Void { MainMenuActions.startGame.dispatch(Page.PVP); }
    function onPVEClicked(evt:js.html.Event):Void { MainMenuActions.startGame.dispatch(Page.PVE); }
    function onTEAMSClicked(evt:js.html.Event):Void { MainMenuActions.startGame.dispatch(Page.TEAMS); }
}
