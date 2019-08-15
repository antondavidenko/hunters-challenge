package mainmenu.model;

@:enum
abstract Page(String) {
    var PVP = 'PVP';
    var PVE = 'PVE';
    var TEAMS = 'TEAMS';
    var HELP = 'HELP';
}

typedef MainMenuState = {
    entries:Array<LobbyItemState>,
    page:Page,
    fullscreen:Bool
}

typedef LobbyItemState = {
    ?id:String,
    classId:Int,
    controlId:Int,
    color:String
}

typedef RootState = {
    mainMenuState:MainMenuState
}