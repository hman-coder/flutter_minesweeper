import 'package:flutter/material.dart';

extension IsDark on Color {
  bool get isDark {
    return _darkBackgroundColors.contains(this);    
  }
}

// Color palletes urls:
// https://coolors.co/d4afb9-d3bfce-d1cfe2-9cadce-7ec4cf-52b2cf-000000
// https://coolors.co/51a3a3-75485e-cb904d-cc92c2-37423d-c57b57-ffffff
// https://coolors.co/51a3a3-75485e-cb904d-cc92c2-3f612d-c57b57-ffffff

// General use
const Color kcTransparentColor = Colors.transparent;

const Color kcBlueGreyColor = Colors.blueGrey;

const Color kcCardDarkWhite = Color(0x12FFFFFF);

// Texts and Icons
const Color kcForegroundDarkBlue = Color(0xFF52B2CF); // Maximum blue
const Color kcForegroundDarkWhite = Colors.white;

const Color kcForegroundLightCopper = Color(0xFFC57B57); // Copper Crayola
const Color kcForegroundLightBlack = Colors.black;

const Color kcForegroundLightBlue = Color(0xFF2196F3);

// Elements
// Light
const Color kcElementLightBlackOlive = Color(0xFF37423D); 
const Color kcElementLightDarkMossGreen = Color(0xFF3F612D);
const Color kcElementLightEggplant = Color(0xFF75485E); 
const Color kcElementLightAmber = Colors.amber;
const Color kcElementLightPersianOrange = Color(0xFFCB904D);
const Color kcElementLightCadetBlue = Color(0xFF51A3A3); 
const Color kcElementLightBlack = Colors.black;

// Dark
const Color kcElementDarkMiddleBlue = Color(0xFF7EC4CF);
const Color kcElementDarkThistle = Color(0xFFD3BFCE); 
const Color kcElementDarkWhite = Colors.white;
const Color kcElementDarkWildBlueYonder = Color(0xFF9CADCE);
const Color kcElementDarkCameoPink = Color(0xFFD4AFB9); 

// -- Tile
const Color kcTileColor = Colors.grey;

// -- Background

// Light
const Color kcBackgroundWhiteColor = Colors.white;

// Dark
const Color kcBackgroundDarkColor = Color(0xFF121212);


// Dark background colors
const List<Color> _darkBackgroundColors = [kcBackgroundDarkColor];