package mainmenu;

import msignal.Signal.Signal1;

class MainMenuSignals
{
    public static var navigateToPage:Signal1<String> = new Signal1();
    public static var startGame:Signal1<Array<Dynamic>> = new Signal1();
}