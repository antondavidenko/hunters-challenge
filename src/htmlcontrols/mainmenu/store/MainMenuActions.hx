package htmlcontrols.mainmenu.store;

import msignal.Signal.Signal1;

class MainMenuActions
{
    public static var navigateToPage:Signal1<Page> = new Signal1();
    public static var startGame:Signal1<Page> = new Signal1();
}

enum Page {
    PVP;
    PVE;
    TEAMS;
    HELP;
}