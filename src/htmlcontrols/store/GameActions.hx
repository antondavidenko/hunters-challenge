package htmlcontrols.store;

import msignal.Signal.Signal1;

class GameActions
{
    public static var navigateToPage:Signal1<String> = new Signal1();
    public static var startGame:Signal1<String> = new Signal1();

    public static var pagePVE:String = "PVE";
    public static var pagePVP:String = "PVP";
    public static var pageTeams:String = "TEAMS";
    public static var pageHelp:String = "HELP";
}