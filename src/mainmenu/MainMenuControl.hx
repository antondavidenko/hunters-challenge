package mainmenu;

import mainmenu.model.DataTypes.MainMenuState;
import js.html.HtmlElement;
import mainmenu.model.DefaultValues;
import mainmenu.model.Lobby;
import redux.Redux;
import mainmenu.action.LobbyAction;
import mainmenu.view.MainMenuScreen;
import js.Browser;
import js.html.DivElement;
import react.ReactDOM;
import react.ReactMacro.jsx;
import redux.Store;
import redux.react.Provider;
import redux.StoreBuilder.*;

class MainMenuControl
{
    public function new()
    {
        var store = createMainMenuStore();
        var root = cast js.Browser.document.getElementById('MainMenu');
        render(root, store);
        store.dispatch(LobbyAction.SetPage(DefaultValues.getDefaultPage()));
    }

    static public function createMainMenuStore():Store<MainMenuState>
    {
        var mainMenuState = new Lobby();

        var rootReducer = Redux.combineReducers({
            mainMenuState: mapReducer(LobbyAction, mainMenuState)
        });

        return createStore(rootReducer);
    }

    static function render(root:DivElement, store:Store<MainMenuState>)
    {
        var app = ReactDOM.render(jsx('
            <Provider store=$store>
                <MainMenuScreen></MainMenuScreen>
            </Provider>
        '), root);
    }

    public function onResize(windowWidth:Int, windowHeight:Int):Void {
        var maxMainMenuSize:Int = Std.parseInt(DefaultValues.maxMainMenuSize);
        var loginPanel:HtmlElement;
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        loginPanel.style.marginTop = (windowHeight - maxMainMenuSize)/2 + 'px';
    }

    public function hide():Void {
        var loginPanel:HtmlElement;
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        loginPanel.style.display = "none";
    }
}