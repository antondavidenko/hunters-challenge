package mainmenu.view.pages;

import mainmenu.model.DataTypes.LobbyItemState;
import react.ReactComponent;
import react.ReactMacro.jsx;
import mainmenu.view.components.LobbyItemView;

typedef LobbyViewProps = {
    list: Array<LobbyItemState>,
    onPlayClicked: Dynamic->Void
}

class LobbyView extends ReactComponentOfProps<LobbyViewProps> {

    override public function render() {
        return jsx('
            <div>
                ${renderList()}
                <button id="loginButton" onClick="${props.onPlayClicked}">PLAY</button>
            </div>
        ');
    }

    function renderList() {
        return [for (item in props.list)
            jsx('<LobbyItemView key=${item.id} item=$item/>')
        ];
    }

}