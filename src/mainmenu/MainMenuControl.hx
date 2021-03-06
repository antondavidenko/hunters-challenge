package mainmenu;

import msignal.Signal.Signal1;
import mainmenu.model.DataTypes.MainMenuState;
import js.html.HtmlElement;
import mainmenu.model.DefaultValues;
import mainmenu.model.Lobby;
import redux.Redux;
import mainmenu.action.MainMenuActions;
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
        store.dispatch(MainMenuActions.SetPage(DefaultValues.getDefaultPage()));
    }

    static public function createMainMenuStore():Store<MainMenuState>
    {
        var mainMenuState = new Lobby();

        var rootReducer = Redux.combineReducers({
            mainMenuState: mapReducer(MainMenuActions, mainMenuState)
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

    public function hide():Void {
        var loginPanel:HtmlElement;
        loginPanel = cast js.Browser.document.getElementById("loginPanel");
        loginPanel.style.display = "none";
    }
}