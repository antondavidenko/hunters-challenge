package mainmenu.action;

import mainmenu.model.DataTypes.Page;

enum MainMenuActions
{
    SetColor(id:String, colorId:String);
    SetControl(id:String, controlId:Int);
    SetClass(id:String, classId:Int);
    SetPage(pageId:Page);
    SetFullscreen(isFullScreen:Bool);
}