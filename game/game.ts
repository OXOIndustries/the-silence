/**
 * Created by Gedan on 06/09/2014.
 */

/// <reference path="ui/ui.ts"/>

import ui = require('./ui/ui');
import assets = require("./Preloader");

// Core game class.
export class Game
{
	// <editor-fold desc="Singleton Instance">
	private static _instance:Game = null;

	public static getInstance():Game
	{
		if (Game._instance === null)
		{
			Game._instance = new Game();
		}
		return Game._instance;
	}
	//</editor-fold>

	constructor()
	{
		if (Game._instance !== null)
		{
			throw "Only one instance of the Game class may exist!";
		}

		this.Create();
	}

	private _canvas:HTMLCanvasElement;
	private _stage:createjs.Stage;
	private _userInterface:ui.UserInterface;

	private Create()
	{
		// Setup base classes required for further init
		this._canvas = <HTMLCanvasElement> document.getElementById("canvas");
		this._stage = new createjs.Stage(this._canvas);
	}

	public Begin()
	{
		assets.Assets.on("complete", (e:createjs.Event) => { this.OnComplete(e) });
		assets.Assets.on("fileload", (e:createjs.Event) => { this.OnProgress(e) });
		assets.Assets.on("error", (e:createjs.Event) => { this.OnError(e) });
		assets.Assets.load();
	}

	private Start()
	{
		this._userInterface = new ui.UserInterface(this._stage);
		this._userInterface.ShowModule("MainMenuModule");
	}

	OnComplete(event:createjs.Event):void
	{
		console.info("Load complete, starting game...");
	}

	OnProgress(event:createjs.Event):void
	{
		console.info("Loaded File:", event.item.src)
	}

	OnError(event:createjs.Event):void
	{
		console.error("Preloader Error:", event.error);
		this._stage.update();
	}
}