package mainmenu.model;

import mainmenu.model.DataTypes.MainMenuState;
import mainmenu.model.DataTypes.Page;
import mainmenu.action.LobbyAction;
import js.Promise;
import react.ReactUtil.copy;
import redux.IReducer;
import redux.StoreMethods;

class Lobby implements IReducer<LobbyAction, MainMenuState> {

    public var initState:MainMenuState = {
        entries:[],
        page:DefaultValues.getDefaultPage()
    };

    public var store:StoreMethods<MainMenuState>;

    var ID = 0;
    var loadPending:Promise<Bool>;

    public function new() {}

    public function reduce(state:MainMenuState, action:LobbyAction):MainMenuState
    {
        ID = 0;
        return switch(action)
        {
            case SetColor(id, color): {
                copy(state, {
                    entries: [
                        for (item in state.entries) {
                            if (item.id != id) item;
                            else {
                                id: item.id,
                                classId: item.classId,
                                controlId: item.controlId,
                                color: color
                            }
                        }
                    ]
                });
            }

            case SetControl(id, control): {
                copy(state, {
                    entries: [
                        for (item in state.entries) {
                            if (item.id != id) item;
                            else {
                                id: item.id,
                                classId: item.classId,
                                controlId: control,
                                color: item.color
                            }
                        }
                    ]
                });
            }

            case SetClass(id, classId): {
                copy(state, {
                    entries: [
                        for (item in state.entries) {
                            if (item.id != id) item;
                            else {
                                id: item.id,
                                classId: classId,
                                controlId: item.controlId,
                                color: item.color
                            }
                        }
                    ]
                });
            }

            case SetPage(page): {
                page: page,
                entries: [
                    for (item in DefaultValues.getLobbyByPage(page)) {
                        item.id = '${++ID}';
                        item;
                    }
                ]
            }
        }
    }
}