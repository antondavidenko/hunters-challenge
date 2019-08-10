package mainmenu.view.pages;

import mainmenu.model.DataTypes.LobbyItemState;
import react.ReactComponent;
import react.ReactMacro.jsx;
import redux.Redux.Dispatch;
import mainmenu.view.components.LobbyItemView;

typedef LobbyViewProps = {
    list: Array<LobbyItemState>,
    ?dispatch: Dispatch
}

class LobbyView extends ReactComponentOfProps<LobbyViewProps> {
    override public function render() {
        return jsx('
            <div>
                ${renderList()}
                <button id="loginButton" onClick="$onPlayClicked">PLAY</button>
            </div>
        ');
    }

    function renderList() {
        return [for (item in props.list)
            jsx('<LobbyItemView key=${item.id} item=$item/>')
        ];
    }

    function onPlayClicked():Void {
        trace("PLAY PRESSED!!!");
    }
}