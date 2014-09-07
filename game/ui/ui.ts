/**
 * Created by Gedan on 06/09/2014.
 */

/// <reference path="../../lib/createjs.d.ts"/>

/*
* TODO: Canvas setup might work better using a two-layer sandwhich.
* A rear canvas where graphics elements are drawn (base) set to a negative (rear) z-index.
* Elements that exist within the DOM (large text blocks) at a regular z-index.
* A front canvas where "hidden" graphics are drawn expressly to tie into stage events set to a positive (front) z-index.
 */

export class UserInterface
{
	// Core rendering
	private _baseStage:createjs.Stage;

	constructor(baseStage:createjs.Stage)
	{
		this._baseStage = baseStage;
	}

	// Available Modules
	private _interfaceModules:createjs.DisplayObject[];
	private _activeModule:createjs.DisplayObject;

	// Module Interface
	ShowModule(name:string):void
	{

	}
}

export class UISettings
{
	static backgroundColor:string = "";
	static foregroundColor:string = "";
	static highlightColor:string = "";
	static paleColor:string = "";

	static goodColor:string = "#0CD71C";
	static badColor:string = "#FF0000";
	static debugColor:string = "#FFA90A";

	static mainTextColor:string = "";
	static keyBindColor:string = "";

	static indoorColor:string = "";
	static outdoorColor:string = "";
}