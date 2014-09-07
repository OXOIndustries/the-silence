/**
 * Created by Gedan on 06/09/2014.
 */

/// <reference path="game.ts"/>

import Game = require('game');

// Core init function, basically called as soon as everything else is loaded and ready
window.onload = () =>
{
	console.info("Source loaded, beginning game init.");

	Game.Game.getInstance().Begin();
}