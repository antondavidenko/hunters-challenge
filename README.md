# HUNTERS CHALLENGE game

## Overview

This is a simple game demonstrating multi modular (component) interaction architecture in Haxe:
- GAME : Phaser
- SIDE PANEL : React
- MAIN MENU : React+Redux
- SOUNDS : HOWLERJS

RUN DEMO: http://antondavidenko.com/games/arpg_v8/

TRELLO BOARD (Future improvements plan): https://trello.com/b/DBn0Qjng/hunters-challange

## Installation
> This application requires NPM and Haxe 3.2.1 or greater

Install NPM libraries:

	npm install

Install Haxe libraries

	haxelib install react
	haxelib install react-router
	haxelib install redux

For more information about the libraries:

- https://github.com/massiveinteractive/haxe-react
- https://github.com/elsassph/haxe-react-router
- https://github.com/elsassph/haxe-redux

### NPM scripts

The `package.json` contains a number of helper scripts (all the `npm run <script name>` below).

NPM scripts are a convenient and lightweight way to write crossplatform mini scripts.

### NPM dependencies

NPM libraries are referenced in `src/libs.js` - add libraries your Haxe code will need.

Compile them into `bin/libs.js` for development:

	npm run libs

See [Adding NPM dependencies](#adding-npm-dependencies) for a detailed process.

### Release build

Release build as a single Haxe-JS bundle:

	npm run release

This command does: 

- remove JS/MAP files in `bin/`
- build and minify `libs.js`
- build and minify the Haxe JS bundles 

This is obviously a naive setup - you'll probably want to add some SCSS/LESS and 
assets preprocessors.

## THANKS

- Many thanks to: https://github.com/elsassph
All my work on this game including even this file based on his samples )

- Great thanks to: https://github.com/sebbernery
His phaser 3 lib for HAXE and samples was first I begin with on this game.