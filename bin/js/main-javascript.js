// Generated by Haxe 3.4.7
(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
var Main = function() {
	model_DefaultValues.init();
	ReactDOM.render({ "$$typeof" : $$tre, type : htmlcontrols_lobby_LobbyPanel, props : { slots : model_DefaultValues.slots}, key : null, ref : null},window.document.getElementById("lobby"));
	this.gameCanvas = window.document.getElementById("gameCanvas");
	this.sidePanel = window.document.getElementById("sidePanel");
	this.loginPanel = window.document.getElementById("loginPanel");
	this.HTML5game = window.document.getElementById("HTML5game");
	window.addEventListener("resize",$bind(this,this.onResize));
	this.onResize();
	this.sidePanelControl = new htmlcontrols_SidePanelControl();
	this.loginPanelControl = new htmlcontrols_LoginPanelControl($bind(this,this.onLogin));
	this.phaserGame = new phasergame_PhaserGame();
};
Main.__name__ = true;
Main.main = function() {
	return new Main();
};
Main.prototype = {
	onResize: function() {
		var w = window.innerWidth;
		var h = window.innerHeight;
		var multiplayer = w / 950 < h / 654 ? w / 950 : h / 654;
		this.gameCanvas.style.height = (654 * multiplayer | 0) + "px";
		this.gameCanvas.style.width = (950 * multiplayer | 0) + "px";
		this.gameCanvas.style.position = "absolute";
		this.gameCanvas.style.left = w - 950 * multiplayer + "px";
		this.gameCanvas.style.top = (h - 654 * multiplayer) / 2 + "px";
		this.sidePanel.style.width = (w - 950 * multiplayer - 32 | 0) + "px";
	}
	,onLogin: function() {
		model_Model.init();
		this.gameCanvas.style.display = "block";
		this.sidePanel.style.display = "block";
		this.loginPanel.style.display = "none";
		this.phaserGame.init(this.gameCanvas,this.sidePanelControl);
		this.phaserGame.setCallbackOnGameEnd($bind(this,this.onGameEnd));
		if(model_Model.screenMode == "Fullscreen") {
			this.HTML5game.requestFullscreen();
		}
	}
	,onGameEnd: function() {
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) {
		v = parseInt(x);
	}
	if(isNaN(v)) {
		return null;
	}
	return v;
};
Std.random = function(x) {
	if(x <= 0) {
		return 0;
	} else {
		return Math.floor(Math.random() * x);
	}
};
var Utils = function() { };
Utils.__name__ = true;
Utils.distanceBetween = function(x1,y1,x2,y2) {
	var dx = x1 - x2;
	var dy = y1 - y2;
	return Math.sqrt(dx * dx + dy * dy);
};
Utils.getRandomScreenX = function() {
	return Std.random(model_Model.phaserGameWidth);
};
Utils.getRandomScreenY = function() {
	return Std.random(model_Model.phaserGameHeight);
};
var haxe_IMap = function() { };
haxe_IMap.__name__ = true;
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.__name__ = true;
haxe_Timer.prototype = {
	run: function() {
	}
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = true;
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	setReserved: function(key,value) {
		if(this.rh == null) {
			this.rh = { };
		}
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) {
			return null;
		} else {
			return this.rh["$" + key];
		}
	}
};
var htmlcontrols_LoginPanelControl = function(onLogin) {
	var _gthis = this;
	var button = window.document.getElementById("loginButton");
	button.onclick = function(event) {
		_gthis.updateDefaultValuesByInput();
		onLogin();
		return false;
	};
};
htmlcontrols_LoginPanelControl.__name__ = true;
htmlcontrols_LoginPanelControl.prototype = {
	updateDefaultValuesByInput: function() {
		var _g = 0;
		while(_g < 6) {
			var i = _g++;
			model_DefaultValues.slots[i].label = this.getById("slot" + i + "Label");
			model_DefaultValues.slots[i].charType = this.getById("slot" + i + "Class");
			model_DefaultValues.slots[i].controlType = this.getById("slot" + i + "Control");
			var spawnXY = Std.string(this.getById("slot" + i + "Spawn")).split(",");
			model_DefaultValues.slots[i].x = Std.parseInt(spawnXY[0]);
			model_DefaultValues.slots[i].y = Std.parseInt(spawnXY[1]);
		}
		model_DefaultValues.mobAmount = Std.parseInt(this.getById("mobsAmount"));
		model_DefaultValues.baseExpGain = parseFloat(this.getById("baseExp"));
		model_DefaultValues.maxLvl = Std.parseInt(this.getById("maxLvl"));
		model_DefaultValues.screenMode = this.getById("modeSwitcher");
		model_DefaultValues.showLabel = this.getById("labelsSwitcher") == "ON";
	}
	,getById: function(id) {
		var htmlData = window.document.getElementById(id);
		return htmlData.value;
	}
	,setById: function(id,value) {
		var htmlData = window.document.getElementById(id);
		htmlData.value = value;
	}
};
var htmlcontrols_SidePanelControl = function() {
};
htmlcontrols_SidePanelControl.__name__ = true;
htmlcontrols_SidePanelControl.prototype = {
	updateView: function() {
		this.mapDataToHTML("sidePanel_name1",model_SidePanelModel.LABEL1);
		this.mapDataToHTML("sidePanel_name2",model_SidePanelModel.LABEL2);
		this.mapDataToHTML("sidePanel_name3",model_SidePanelModel.LABEL3);
		this.mapDataToHTML("sidePanel_name4",model_SidePanelModel.LABEL4);
		this.mapDataToHTML("sidePanel_name5",model_SidePanelModel.LABEL5);
		this.mapDataToHTML("sidePanel_name6",model_SidePanelModel.LABEL6);
		var _this = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player1progress",this.getProgressString(__map_reserved["p1"] != null ? _this.getReserved("p1") : _this.h["p1"]));
		var _this1 = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player2progress",this.getProgressString(__map_reserved["p2"] != null ? _this1.getReserved("p2") : _this1.h["p2"]));
		var _this2 = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player3progress",this.getProgressString(__map_reserved["p3"] != null ? _this2.getReserved("p3") : _this2.h["p3"]));
		var _this3 = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player4progress",this.getProgressString(__map_reserved["p4"] != null ? _this3.getReserved("p4") : _this3.h["p4"]));
		var _this4 = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player5progress",this.getProgressString(__map_reserved["p5"] != null ? _this4.getReserved("p5") : _this4.h["p5"]));
		var _this5 = model_Model.playersData;
		this.mapProgressToHTML("sidePanel_Player6progress",this.getProgressString(__map_reserved["p6"] != null ? _this5.getReserved("p6") : _this5.h["p6"]));
	}
	,mapDataToHTML: function(htmlId,data) {
		var nameHtml = window.document.getElementById(htmlId);
		nameHtml.innerHTML = "<b>" + data + "</b>";
	}
	,mapProgressToHTML: function(htmlId,data) {
		var progressHtml = window.document.getElementById(htmlId);
		progressHtml.style.width = data;
	}
	,getProgressString: function(data) {
		if(data != null) {
			return data.expGained + "%";
		} else {
			return "0%";
		}
	}
	,updateData: function() {
		var _this = model_Model.playersData;
		model_SidePanelModel.LABEL1 = this.getLabelValueByPlayerData(__map_reserved["p1"] != null ? _this.getReserved("p1") : _this.h["p1"]);
		var _this1 = model_Model.playersData;
		model_SidePanelModel.LABEL2 = this.getLabelValueByPlayerData(__map_reserved["p2"] != null ? _this1.getReserved("p2") : _this1.h["p2"]);
		var _this2 = model_Model.playersData;
		model_SidePanelModel.LABEL3 = this.getLabelValueByPlayerData(__map_reserved["p3"] != null ? _this2.getReserved("p3") : _this2.h["p3"]);
		var _this3 = model_Model.playersData;
		model_SidePanelModel.LABEL4 = this.getLabelValueByPlayerData(__map_reserved["p4"] != null ? _this3.getReserved("p4") : _this3.h["p4"]);
		var _this4 = model_Model.playersData;
		model_SidePanelModel.LABEL5 = this.getLabelValueByPlayerData(__map_reserved["p5"] != null ? _this4.getReserved("p5") : _this4.h["p5"]);
		var _this5 = model_Model.playersData;
		model_SidePanelModel.LABEL6 = this.getLabelValueByPlayerData(__map_reserved["p6"] != null ? _this5.getReserved("p6") : _this5.h["p6"]);
	}
	,getLabelValueByPlayerData: function(data) {
		if(data != null) {
			return "" + data.label + " : mob slayed=" + data.slayedCounter + " lvl: " + data.currentLevel;
		} else {
			return "";
		}
	}
	,update: function() {
		this.updateData();
		this.updateView();
	}
};
var htmlcontrols_lobby_LobbyPanel = function(props) {
	React.Component.call(this,props);
};
htmlcontrols_lobby_LobbyPanel.__name__ = true;
htmlcontrols_lobby_LobbyPanel.__super__ = React.Component;
htmlcontrols_lobby_LobbyPanel.prototype = $extend(React.Component.prototype,{
	render: function() {
		return { "$$typeof" : $$tre, type : "table", props : { cellPadding : "0", cellSpacing : "0", children : { "$$typeof" : $$tre, type : "tbody", props : { children : [{ "$$typeof" : $$tre, type : "tr", props : { children : [{ "$$typeof" : $$tre, type : "th", props : { children : { "$$typeof" : $$tre, type : "b", props : { children : "Name"}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "th", props : { children : { "$$typeof" : $$tre, type : "b", props : { children : "Class"}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "th", props : { children : { "$$typeof" : $$tre, type : "b", props : { children : "Control"}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "th", props : { children : { "$$typeof" : $$tre, type : "b", props : { children : "Spawn: x,y"}, key : null, ref : null}}, key : null, ref : null}]}, key : null, ref : null},this.createChildren()]}, key : null, ref : null}}, key : null, ref : null};
	}
	,createChildren: function() {
		var _g = [];
		var _g2 = 0;
		var _g1 = this.props.slots.length;
		while(_g2 < _g1) {
			var i = _g2++;
			_g.push({ "$$typeof" : $$tre, type : "tr", props : { children : [{ "$$typeof" : $$tre, type : "td", props : { children : { "$$typeof" : $$tre, type : htmlcontrols_lobby_TextInput, props : { defaultValue : this.props.slots[i].label, id : this.getNameId(i)}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "td", props : { children : { "$$typeof" : $$tre, type : htmlcontrols_lobby_SelectInput, props : { defaultValue : this.props.slots[i].charType, id : this.getClassId(i), options : this.getOptionsClass()}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "td", props : { children : { "$$typeof" : $$tre, type : htmlcontrols_lobby_SelectInput, props : { defaultValue : this.props.slots[i].controlType, id : this.getControlId(i), options : this.getOptionsControl()}, key : null, ref : null}}, key : null, ref : null},{ "$$typeof" : $$tre, type : "td", props : { children : { "$$typeof" : $$tre, type : htmlcontrols_lobby_TextInput, props : { defaultValue : this.getXY(i), id : this.getSpawnId(i)}, key : null, ref : null}}, key : null, ref : null}]}, key : null, ref : null});
		}
		return _g;
	}
	,getNameId: function(i) {
		return "slot" + i + "Label";
	}
	,getClassId: function(i) {
		return "slot" + i + "Class";
	}
	,getControlId: function(i) {
		return "slot" + i + "Control";
	}
	,getSpawnId: function(i) {
		return "slot" + i + "Spawn";
	}
	,getXY: function(i) {
		return "" + this.props.slots[i].x + "," + this.props.slots[i].y;
	}
	,getOptionsClass: function() {
		return [model_PlayerType.HORSEMAN,model_PlayerType.BOWMAN,model_PlayerType.ELF,model_PlayerType.MAGE,model_PlayerType.SWORDMAN];
	}
	,getOptionsControl: function() {
		return [model_ControlType.MOUSE,model_ControlType.AWSD,model_ControlType.ARROWS,model_ControlType.BOT_SIMPLE,model_ControlType.BOT_HARD,model_ControlType.NONE];
	}
});
var htmlcontrols_lobby_SelectInput = function(props) {
	React.Component.call(this,props);
};
htmlcontrols_lobby_SelectInput.__name__ = true;
htmlcontrols_lobby_SelectInput.__super__ = React.Component;
htmlcontrols_lobby_SelectInput.prototype = $extend(React.Component.prototype,{
	render: function() {
		return { "$$typeof" : $$tre, type : "select", props : { defaultValue : this.props.defaultValue, id : this.props.id, children : this.createOptions()}, key : null, ref : null};
	}
	,createOptions: function() {
		var _g = [];
		var _g2 = 0;
		var _g1 = this.props.options.length;
		while(_g2 < _g1) {
			var i = _g2++;
			var tmp = this.props.options[i];
			var tmp1 = this.props.options[i];
			_g.push({ "$$typeof" : $$tre, type : "option", props : { value : tmp, children : tmp1}, key : null, ref : null});
		}
		return _g;
	}
});
var htmlcontrols_lobby_TextInput = function(props) {
	React.Component.call(this,props);
};
htmlcontrols_lobby_TextInput.__name__ = true;
htmlcontrols_lobby_TextInput.__super__ = React.Component;
htmlcontrols_lobby_TextInput.prototype = $extend(React.Component.prototype,{
	render: function() {
		return { "$$typeof" : $$tre, type : "input", props : { id : this.props.id, defaultValue : this.props.defaultValue, type : "text"}, key : null, ref : null};
	}
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0 ? "," : "") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var model_DefaultValues = function() { };
model_DefaultValues.__name__ = true;
model_DefaultValues.init = function() {
	model_DefaultValues.slots.push(new model_Slot("Player 1",model_PlayerType.HORSEMAN,model_ControlType.MOUSE,400,300,"p1"));
	model_DefaultValues.slots.push(new model_Slot("bot 1",model_PlayerType.SWORDMAN,model_ControlType.BOT_SIMPLE,200,300,"p2"));
	model_DefaultValues.slots.push(new model_Slot("bot 2",model_PlayerType.SWORDMAN,model_ControlType.BOT_SIMPLE,300,300,"p3"));
	model_DefaultValues.slots.push(new model_Slot("bot 3",model_PlayerType.SWORDMAN,model_ControlType.BOT_SIMPLE,500,300,"p4"));
	model_DefaultValues.slots.push(new model_Slot("bot 4",model_PlayerType.SWORDMAN,model_ControlType.BOT_SIMPLE,600,300,"p5"));
	model_DefaultValues.slots.push(new model_Slot("bot 5",model_PlayerType.SWORDMAN,model_ControlType.BOT_SIMPLE,700,300,"p6"));
};
var model_Slot = function(label,charType,controlType,x,y,name) {
	this.name = name;
	this.controlType = controlType;
	this.charType = charType;
	this.x = x;
	this.y = y;
	this.label = label;
};
model_Slot.__name__ = true;
var model_CharacterConfig = function() {
};
model_CharacterConfig.__name__ = true;
var model_Model = function() { };
model_Model.__name__ = true;
model_Model.init = function() {
	model_Model.character.DEFAULT_POSE_ID = 7;
	model_Model.character.MOVE_SPEED = 150;
	model_Model.character.MIN_DISTANCE = 3;
	model_Model.mobAmount = model_DefaultValues.mobAmount;
	model_Model.maxLvl = model_DefaultValues.maxLvl;
	model_Model.baseExpGain = model_DefaultValues.baseExpGain;
	model_Model.screenMode = model_DefaultValues.screenMode;
	model_Model.showLabel = model_DefaultValues.showLabel;
	var _g = 0;
	while(_g < 6) {
		var i = _g++;
		model_Model.playersStartConfig.push(model_Model.getCharStartConfigByDefaultValues(i));
	}
};
model_Model.getCharStartConfigByDefaultValues = function(id) {
	var charType = model_DefaultValues.slots[id].charType;
	var name = model_DefaultValues.slots[id].name;
	var label = model_DefaultValues.slots[id].label;
	var x = model_DefaultValues.slots[id].x;
	var y = model_DefaultValues.slots[id].y;
	var control = model_DefaultValues.slots[id].controlType;
	return new model_CharStartConfig(charType,x,y,label,name,control);
};
var model_PhaserGameModel = function() {
};
model_PhaserGameModel.__name__ = true;
var model_PlayerType = function() {
};
model_PlayerType.__name__ = true;
var model_ControlType = function() {
};
model_ControlType.__name__ = true;
var model_CharStartConfig = function(charType,x,y,label,name,control) {
	this.charType = charType;
	this.x = x;
	this.y = y;
	this.label = label;
	this.name = name;
	this.control = control;
};
model_CharStartConfig.__name__ = true;
var model_PlayerData = function(slayedCounter,expGained,currentLevel,label,control) {
	this.slayedCounter = slayedCounter;
	this.expGained = expGained;
	this.currentLevel = currentLevel;
	this.label = label;
	this.control = control;
};
model_PlayerData.__name__ = true;
var model_MobData = function(currentLevel) {
	this.currentLevel = currentLevel;
};
model_MobData.__name__ = true;
var model_SidePanelModel = function() { };
model_SidePanelModel.__name__ = true;
var phasergame_CharackterAndMobData = function(charackter,mob) {
	this.charackter = charackter;
	this.mob = mob;
};
phasergame_CharackterAndMobData.__name__ = true;
var phasergame_CollisionDetector = function(phaserScene) {
	this.phaserScene = phaserScene;
};
phasergame_CollisionDetector.__name__ = true;
phasergame_CollisionDetector.prototype = {
	init: function(allCharacktersList,allMobList) {
		this.allCharacktersList = allCharacktersList;
		this.allMobList = allMobList;
		this.initCollisionDetections();
	}
	,onCharackterAndMob: function(callback) {
		this.onCharackterAndMobCallback = callback;
	}
	,initCollisionDetections: function() {
		var _gthis = this;
		var _g = 0;
		var _g1 = this.allCharacktersList;
		while(_g < _g1.length) {
			var charackter = _g1[_g];
			++_g;
			var _g2 = 0;
			var _g3 = this.allMobList;
			while(_g2 < _g3.length) {
				var mob = _g3[_g2];
				++_g2;
				var charackterBody = charackter.getPhysicBody();
				var mobBody = mob.getPhysicBody();
				var collision = this.phaserScene.physics.add.overlap(charackterBody,mobBody,function(charackter1,mob1) {
					_gthis.onCharackterAndMobCallback(new phasergame_CharackterAndMobData(charackter1.name,mob1.name));
				},null,this);
			}
		}
	}
};
var phasergame_MoverCharacters = function() {
	this.allPlayersList = [];
	this.allMobList = [];
};
phasergame_MoverCharacters.__name__ = true;
phasergame_MoverCharacters.prototype = {
	setKeys: function(keys) {
		this.keys = keys;
	}
	,setCursor: function(cursor) {
		this.cursor = cursor;
	}
	,initMobs: function(allMobList) {
		this.allMobList = allMobList;
		var _g = 0;
		while(_g < allMobList.length) {
			var currentMob = allMobList[_g];
			++_g;
			currentMob.setGoToXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
		}
		var timer = new haxe_Timer(model_Model.mobTimeoutDelay);
		timer.run = function() {
			var randomMob = Std.random(allMobList.length);
			var randomMob1 = allMobList[randomMob];
			randomMob1.setGoToXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
		};
	}
	,initPlayers: function(allPlayersList) {
		this.allPlayersList = allPlayersList;
		var _g = 0;
		while(_g < allPlayersList.length) {
			var currentPlayer = allPlayersList[_g];
			++_g;
			var id = currentPlayer.getPhysicBody().name;
			var _this = model_Model.playersData;
			if((__map_reserved[id] != null ? _this.getReserved(id) : _this.h[id]).control == model_ControlType.BOT_SIMPLE) {
				currentPlayer.setGoToXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
			}
		}
		var timer = new haxe_Timer(model_Model.botTimeoutDelay);
		timer.run = function() {
			var randomPlayer = Std.random(allPlayersList.length);
			var randomPlayer1 = allPlayersList[randomPlayer];
			var id1 = randomPlayer1.getPhysicBody().name;
			var _this1 = model_Model.playersData;
			if((__map_reserved[id1] != null ? _this1.getReserved(id1) : _this1.h[id1]).control == model_ControlType.BOT_SIMPLE) {
				randomPlayer1.setGoToXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
			}
		};
	}
	,onPointerdown: function(pointer) {
		var _g = 0;
		var _g1 = this.allPlayersList;
		while(_g < _g1.length) {
			var currentPlayer = _g1[_g];
			++_g;
			var id = currentPlayer.getPhysicBody().name;
			var _this = model_Model.playersData;
			if((__map_reserved[id] != null ? _this.getReserved(id) : _this.h[id]).control == model_ControlType.MOUSE) {
				currentPlayer.setGoToXY(pointer.x,pointer.y);
			}
		}
	}
	,update: function() {
		this.checkAWSDKeys();
		this.checkCursorKeys();
	}
	,checkAWSDKeys: function() {
		var deltaAWSDx = this.defineCursorMoveAxis(this.keys.D.isDown,this.keys.A.isDown);
		var deltaAWSDy = this.defineCursorMoveAxis(this.keys.S.isDown,this.keys.W.isDown);
		if(deltaAWSDx != 0 || deltaAWSDy != 0) {
			this.onControlKeysPressed(deltaAWSDx,deltaAWSDy,model_ControlType.AWSD);
		}
	}
	,checkCursorKeys: function() {
		var deltaCursorX = this.defineCursorMoveAxis(this.cursor.right.isDown,this.cursor.left.isDown);
		var deltaCursorY = this.defineCursorMoveAxis(this.cursor.down.isDown,this.cursor.up.isDown);
		if(deltaCursorX != 0 || deltaCursorY != 0) {
			this.onControlKeysPressed(deltaCursorX,deltaCursorY,model_ControlType.ARROWS);
		}
	}
	,defineCursorMoveAxis: function(isPositive,isNegative) {
		var delta = 10;
		var axis = isPositive ? delta : 0;
		if(isNegative) {
			return -1 * delta;
		} else {
			return axis;
		}
	}
	,onControlKeysPressed: function(deltaX,deltaY,keysFlag) {
		var _g = 0;
		var _g1 = this.allPlayersList;
		while(_g < _g1.length) {
			var currentPlayer = _g1[_g];
			++_g;
			var id = currentPlayer.getPhysicBody().name;
			var _this = model_Model.playersData;
			if((__map_reserved[id] != null ? _this.getReserved(id) : _this.h[id]).control == keysFlag) {
				var targetX = (currentPlayer.getPhysicBody().x | 0) + deltaX;
				var targetY = (currentPlayer.getPhysicBody().y | 0) + deltaY;
				currentPlayer.setGoToXY(targetX,targetY);
			}
		}
	}
};
var phasergame_PhaserGame = function() {
};
phasergame_PhaserGame.__name__ = true;
phasergame_PhaserGame.prototype = {
	init: function(gameCanvas,sidePanelControl) {
		this.scene = new phasergame_PhaserScene(sidePanelControl);
		this.scene.setCallbackOnGameEnd($bind(this,this.onGameEndPhaserGame));
		this.game = new Phaser.Game({ width : model_Model.phaserGameWidth, height : model_Model.phaserGameHeight, canvas : gameCanvas, scene : this.scene, physics : { "default" : "arcade", "arcade" : { "debug" : false}}});
	}
	,setCallbackOnGameEnd: function(callback) {
		this.onGameEnd = callback;
	}
	,onGameEndPhaserGame: function() {
		this.onGameEnd();
	}
};
var phasergame_PhaserScene = function(sidePanelControl) {
	this.isPaused = false;
	Phaser.Scene.call(this);
	this.background = new phasergame_sceneobjects_Background(this);
	this.playersCollection = new phasergame_sceneobjects_PlayersCollection(this);
	this.mobsCollection = new phasergame_sceneobjects_MobsCollection(this);
	this.collisionDetector = new phasergame_CollisionDetector(this);
	this.moverCharacters = new phasergame_MoverCharacters();
	this.sidePanelControl = sidePanelControl;
};
phasergame_PhaserScene.__name__ = true;
phasergame_PhaserScene.__super__ = Phaser.Scene;
phasergame_PhaserScene.prototype = $extend(Phaser.Scene.prototype,{
	setCallbackOnGameEnd: function(callback) {
		this.onGameEnd = callback;
	}
	,preload: function() {
		this.background.preload();
		this.playersCollection.preload();
		this.mobsCollection.preload();
	}
	,create: function() {
		var _gthis = this;
		this.background.init();
		this.playersCollection.init(($_=this.moverCharacters,$bind($_,$_.initPlayers)));
		this.mobsCollection.init(($_=this.moverCharacters,$bind($_,$_.initMobs)));
		this.collisionDetector.init(this.playersCollection.getAllPlayersList(),this.mobsCollection.getAllMobList());
		this.collisionDetector.onCharackterAndMob($bind(this,this.onCharackterAndMobCollision));
		this.input.on("pointerdown",function(pointer) {
			_gthis.moverCharacters.onPointerdown(pointer);
		},this);
		this.moverCharacters.setKeys(this.input.keyboard.addKeys("A,W,S,D"));
		this.moverCharacters.setCursor(this.input.keyboard.createCursorKeys());
	}
	,update: function(time,delta) {
		if(!this.isPaused) {
			Phaser.Scene.prototype.update.call(this,time,delta);
			this.moverCharacters.update();
			this.playersCollection.update(time,delta);
			this.mobsCollection.update(time,delta);
			this.sidePanelControl.update();
			this.checkGameEndCreteria();
		}
	}
	,onCharackterAndMobCollision: function(dataNameId) {
		var key = dataNameId.mob;
		var _this = model_Model.mobsData;
		var mobLvl = (__map_reserved[key] != null ? _this.getReserved(key) : _this.h[key]).currentLevel;
		this.playersCollection.onPlayerSlayMob(dataNameId.charackter,mobLvl);
		this.mobsCollection.onMobSlayed(dataNameId.mob);
	}
	,checkGameEndCreteria: function() {
		var isGameEnd = model_Model.maxLvlInGame == model_Model.maxLvl;
		if(isGameEnd) {
			this.onGameEnd();
			this.showEndGameMessage();
			this.physics.pause();
			this.isPaused = true;
		}
	}
	,showEndGameMessage: function() {
		var header = this.add.text(100,210,"Challenge is over",{ fontFamily : "Arial Black", fontSize : 74, color : "#ccd8ff"});
		header.setStroke("#8ca7f7",16);
		header.setShadow(2,2,"#333333",2,true,true);
		header.depth = 100500;
		var info = this.add.text(120,310,"winner is: " + model_Model.leaderPlayerLabel,{ fontFamily : "Arial Black", fontSize : 46, color : "#ccd8ff"});
		info.setShadow(2,2,"#333333",2,true,true);
		info.depth = 100500;
	}
});
var phasergame_sceneobjects_Background = function(phaserScene) {
	this.phaserScene = phaserScene;
	this.tilesetName = "tiles";
};
phasergame_sceneobjects_Background.__name__ = true;
phasergame_sceneobjects_Background.prototype = {
	preload: function() {
		this.phaserScene.load.image(this.tilesetName,"assets/tiles.png");
	}
	,init: function() {
		var _g = [];
		var _g1 = 0;
		while(_g1 < 22) {
			var x = _g1++;
			var _g2 = [];
			var _g3 = 0;
			while(_g3 < 31) {
				var y = _g3++;
				_g2.push(Std.random(8));
			}
			_g.push(_g2);
		}
		var dynamicMap = _g;
		var map = this.phaserScene.add.tilemap("dynamicMap",32,32,0,0,dynamicMap);
		var tiles = map.addTilesetImage(this.tilesetName);
		var layer = map.createStaticLayer(0,tiles,0,0);
	}
};
var phasergame_sceneobjects_Character = function(phaserScene,config) {
	this.MIN_DISTANCE = model_Model.character.MIN_DISTANCE;
	this.MOVE_SPEED = model_Model.character.MOVE_SPEED;
	this.DEFAULT_POSE_ID = model_Model.character.DEFAULT_POSE_ID;
	this.phaserScene = phaserScene;
	this.config = config;
};
phasergame_sceneobjects_Character.__name__ = true;
phasergame_sceneobjects_Character.prototype = {
	init: function() {
		var _g = 0;
		while(_g < 11) {
			var i = _g++;
			var key = this.getIdByTypeIdAndLineId(this.config.charType,i);
			if(this.phaserScene.anims.get(key) == null) {
				this.phaserScene.anims.create(this.getAnimationConfig(this.config.charType,i));
			}
		}
		this.sprite = this.phaserScene.physics.add.sprite(this.config.x,this.config.y,this.config.charType).setScale(1.5);
		this.sprite.setSize(16,16);
		this.sprite.body.offset.x = 8;
		this.sprite.body.offset.y = 8;
		this.sprite.name = this.config.name;
		this.sprite.depth = this.config.y;
		this.setAnimation(this.DEFAULT_POSE_ID);
		this.setLabel(this.config.label);
	}
	,reinit: function(config) {
		this.config = config;
		var _g = 0;
		while(_g < 11) {
			var i = _g++;
			var key = this.getIdByTypeIdAndLineId(config.charType,i);
			if(this.phaserScene.anims.get(key) == null) {
				this.phaserScene.anims.create(this.getAnimationConfig(config.charType,i));
			}
		}
		this.setAnimation(this.DEFAULT_POSE_ID);
		this.text.text = config.label;
		this.text.updateText();
	}
	,setLabel: function(label) {
		this.text = this.phaserScene.add.text(this.sprite.x,this.sprite.y,label);
		this.text.visible = model_Model.showLabel;
		this.updateTextPosition();
	}
	,setSpeed: function(speed) {
		this.MOVE_SPEED = speed;
	}
	,setAnimation: function(lineId) {
		var animationId = this.getIdByTypeIdAndLineId(this.config.charType,lineId);
		if(this.sprite.anims.getCurrentKey() != animationId) {
			this.sprite.anims.load(animationId);
			this.sprite.anims.play(animationId);
		}
	}
	,getIdByTypeIdAndLineId: function(typeId,lineId) {
		return "typeId:" + typeId + "_lineId:" + lineId;
	}
	,getAnimationConfig: function(typeId,lineId) {
		var result = { key : this.getIdByTypeIdAndLineId(typeId,lineId), frames : this.phaserScene.anims.generateFrameNumbers(typeId,this.getFrameConfigByLineId(lineId)), frameRate : 6, yoyo : true, repeat : -1};
		return result;
	}
	,getFrameConfigByLineId: function(lineId) {
		lineId = (lineId - 1) * 4;
		return this.getFrameConfig(lineId,lineId + 3);
	}
	,getFrameConfig: function(start,end) {
		var result = { start : start, end : end};
		return result;
	}
	,setGoToXY: function(x,y) {
		var tx = x - this.sprite.x;
		var ty = y - this.sprite.y;
		var dist = Math.sqrt(tx * tx + ty * ty);
		var rad = Math.atan2(ty,tx);
		var angle = rad / Math.PI * 180;
		this.setAnimation(this.detectPosByAngle(angle));
		this.phaserScene.physics.moveTo(this.sprite,x,y,this.MOVE_SPEED);
		this.xDestination = x;
		this.yDestination = y;
	}
	,setXY: function(x,y) {
		this.sprite.x = x;
		this.sprite.y = y;
	}
	,detectPosByAngle: function(angle) {
		var result = 3;
		angle += 180;
		if(angle <= 112 && angle >= 67) {
			result = 6;
		}
		if(angle <= 67 && angle >= 22) {
			result = 10;
		}
		if(angle <= 157 && angle >= 112) {
			result = 9;
		}
		if(angle <= 202 && angle >= 157) {
			result = 4;
		}
		if(angle <= 247 && angle >= 202) {
			result = 7;
		}
		if(angle <= 292 && angle >= 247) {
			result = 5;
		}
		if(angle <= 337 && angle >= 292) {
			result = 8;
		}
		return result;
	}
	,update: function(time,delta) {
		this.checkDestinationReached();
		this.sprite.depth = this.sprite.y;
		this.updateTextPosition();
	}
	,updateTextPosition: function() {
		this.text.x = this.sprite.x - this.text.width / 2;
		this.text.y = this.sprite.y - this.sprite.height * 1.35;
		this.text.depth = this.sprite.y + 1;
	}
	,checkDestinationReached: function() {
		var distance = Utils.distanceBetween(this.sprite.x,this.sprite.y,this.xDestination,this.yDestination);
		if(distance < this.MIN_DISTANCE) {
			this.sprite.body.velocity.x = 0;
			this.sprite.body.velocity.y = 0;
			this.sprite.x = this.xDestination;
			this.sprite.y = this.yDestination;
		}
	}
	,getPhysicBody: function() {
		return this.sprite;
	}
};
var phasergame_sceneobjects_MobsCollection = function(phaserScene) {
	this.allMobList = [];
	this.phaserScene = phaserScene;
};
phasergame_sceneobjects_MobsCollection.__name__ = true;
phasergame_sceneobjects_MobsCollection.prototype = {
	preload: function() {
		var frameSize = 32;
		var frmeConfig = { frameWidth : frameSize, frameHeight : frameSize};
		this.phaserScene.load.spritesheet(model_Model.mobTypes[0],"assets/mob1lvl.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_Model.mobTypes[1],"assets/mob2lvl.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_Model.mobTypes[2],"assets/mob3lvl.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_Model.mobTypes[3],"assets/mob4lvl.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_Model.mobTypes[4],"assets/mob5lvl.png",frmeConfig);
	}
	,init: function(onReadyToMove) {
		var lvlId = 0;
		var mobId = 1;
		var _g1 = 0;
		var _g = model_Model.mobAmount;
		while(_g1 < _g) {
			var mob = _g1++;
			var mobConfig = this.getMobConfigByLvl(lvlId,mobId);
			var mob1 = new phasergame_sceneobjects_Character(this.phaserScene,mobConfig);
			mob1.init();
			mob1.setSpeed(model_Model.mobSpeeds[lvlId]);
			this.allMobList.push(mob1);
			var this1 = model_Model.mobsData;
			var k = mob1.getPhysicBody().name;
			var v = new model_MobData(1);
			var _this = this1;
			if(__map_reserved[k] != null) {
				_this.setReserved(k,v);
			} else {
				_this.h[k] = v;
			}
			++mobId;
		}
		onReadyToMove(this.allMobList);
	}
	,getMobConfigByLvl: function(lvlId,mobId) {
		var mobX = Utils.getRandomScreenX();
		var mobY = Utils.getRandomScreenY();
		return new model_CharStartConfig(model_Model.mobTypes[lvlId],mobX,mobY,model_Model.mobLabels[lvlId],"m" + mobId,model_ControlType.BOT_SIMPLE);
	}
	,update: function(time,delta) {
		var _g = 0;
		var _g1 = this.allMobList;
		while(_g < _g1.length) {
			var currentMob = _g1[_g];
			++_g;
			currentMob.update(time,delta);
		}
	}
	,getAllMobList: function() {
		return this.allMobList;
	}
	,onMobSlayed: function(mobId) {
		var mob = this.findMobById(mobId);
		if(mob != null) {
			var lvlId = Std.random(model_Model.maxLvlInGame + 1);
			if(lvlId > model_Model.maxMobLvlId) {
				lvlId = model_Model.maxMobLvlId;
			} else {
				lvlId = lvlId;
			}
			var mobConfig = this.getMobConfigByLvl(lvlId,0);
			mob.reinit(mobConfig);
			mob.setSpeed(model_Model.mobSpeeds[lvlId]);
			mob.setXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
			mob.setGoToXY(Utils.getRandomScreenX(),Utils.getRandomScreenY());
			var this1 = model_Model.mobsData;
			var key = mob.getPhysicBody().name;
			var _this = this1;
			(__map_reserved[key] != null ? _this.getReserved(key) : _this.h[key]).currentLevel = lvlId + 1;
		}
	}
	,findMobById: function(mobId) {
		var _g = 0;
		var _g1 = this.allMobList;
		while(_g < _g1.length) {
			var currentMob = _g1[_g];
			++_g;
			if(currentMob.getPhysicBody().name == mobId) {
				return currentMob;
			}
		}
		return null;
	}
};
var phasergame_sceneobjects_PlayersCollection = function(phaserScene) {
	this.allPlayersList = [];
	this.phaserScene = phaserScene;
};
phasergame_sceneobjects_PlayersCollection.__name__ = true;
phasergame_sceneobjects_PlayersCollection.prototype = {
	preload: function() {
		var frameSize = 32;
		var frmeConfig = { frameWidth : frameSize, frameHeight : frameSize};
		this.phaserScene.load.spritesheet(model_PlayerType.SWORDMAN,"assets/char_swordman.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_PlayerType.BOWMAN,"assets/char_bowman.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_PlayerType.ELF,"assets/char_elf.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_PlayerType.MAGE,"assets/char_mage.png",frmeConfig);
		this.phaserScene.load.spritesheet(model_PlayerType.HORSEMAN,"assets/char_horseman.png",frmeConfig);
	}
	,preparePlayerByConfig: function(config) {
		var player = new phasergame_sceneobjects_Character(this.phaserScene,config);
		player.init();
		this.allPlayersList.push(player);
		return player;
	}
	,init: function(onReadyToMove) {
		var _g = 0;
		while(_g < 6) {
			var i = _g++;
			var playerConfig = model_Model.playersStartConfig[i];
			if(playerConfig.control != model_ControlType.NONE) {
				var player = this.preparePlayerByConfig(playerConfig);
				var this1 = model_Model.playersData;
				var k = playerConfig.name;
				var v = new model_PlayerData(0,0,1,playerConfig.label,playerConfig.control);
				var _this = this1;
				if(__map_reserved[k] != null) {
					_this.setReserved(k,v);
				} else {
					_this.h[k] = v;
				}
			}
		}
		onReadyToMove(this.allPlayersList);
	}
	,update: function(time,delta) {
		var _g = 0;
		var _g1 = this.allPlayersList;
		while(_g < _g1.length) {
			var currentPlayer = _g1[_g];
			++_g;
			currentPlayer.update(time,delta);
		}
	}
	,getAllPlayersList: function() {
		return this.allPlayersList;
	}
	,onPlayerSlayMob: function(playerId,mobLvl) {
		model_Model.totalMobSlayedCounter++;
		var _this = model_Model.playersData;
		this.updatePlayerDataOnMobSlayed(__map_reserved[playerId] != null ? _this.getReserved(playerId) : _this.h[playerId],mobLvl);
	}
	,updatePlayerDataOnMobSlayed: function(playerData,mobLvl) {
		playerData.slayedCounter++;
		playerData.expGained += model_Model.baseExpGain * mobLvl / playerData.currentLevel;
		if(playerData.expGained >= 100) {
			playerData.expGained = 0;
			playerData.currentLevel++;
			if(playerData.currentLevel > model_Model.maxLvlInGame) {
				model_Model.maxLvlInGame = playerData.currentLevel;
				model_Model.leaderPlayerLabel = playerData.label;
			}
		}
	}
};
var react_ReactMacro = function() { };
react_ReactMacro.__name__ = true;
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
var __map_reserved = {};
var $$tre = (typeof Symbol === "function" && Symbol.for && Symbol.for("react.element")) || 0xeac7;
htmlcontrols_lobby_LobbyPanel.displayName = "LobbyPanel";
htmlcontrols_lobby_SelectInput.displayName = "SelectInput";
htmlcontrols_lobby_TextInput.displayName = "TextInput";
model_DefaultValues.slots = [];
model_DefaultValues.mobAmount = 5;
model_DefaultValues.maxLvl = 5;
model_DefaultValues.baseExpGain = 25;
model_DefaultValues.screenMode = "";
model_DefaultValues.showLabel = true;
model_Model.phaserGameWidth = 950;
model_Model.phaserGameHeight = 654;
model_Model.botTimeoutDelay = 1000;
model_Model.mobTimeoutDelay = 100;
model_Model.character = new model_CharacterConfig();
model_Model.playersStartConfig = [];
model_Model.maxLvlInGame = 1;
model_Model.mobTypes = ["mob1lvl","mob2lvl","mob3lvl","mob4lvl","mob5lvl"];
model_Model.mobLabels = ["lvl 1","lvl 2","lvl 3","lvl 4","lvl 5"];
model_Model.mobSpeeds = [100,5,25,300,300];
model_Model.maxMobLvlId = 4;
model_Model.totalMobSlayedCounter = 0;
model_Model.playersData = new haxe_ds_StringMap();
model_Model.mobsData = new haxe_ds_StringMap();
model_PlayerType.SWORDMAN = "swordman";
model_PlayerType.BOWMAN = "bowman";
model_PlayerType.ELF = "elf";
model_PlayerType.MAGE = "mage";
model_PlayerType.HORSEMAN = "horseman";
model_ControlType.MOUSE = "mouse";
model_ControlType.ARROWS = "keys_arrows";
model_ControlType.AWSD = "keys_awsd";
model_ControlType.BOT_SIMPLE = "bot_simple";
model_ControlType.BOT_HARD = "bot_hard";
model_ControlType.NONE = "none";
model_SidePanelModel.LABEL1 = "LABEL1";
model_SidePanelModel.LABEL2 = "LABEL2";
model_SidePanelModel.LABEL3 = "LABEL3";
model_SidePanelModel.LABEL4 = "LABEL4";
model_SidePanelModel.LABEL5 = "LABEL5";
model_SidePanelModel.LABEL6 = "LABEL6";
Main.main();
})();
