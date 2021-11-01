import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData() {
  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    secondaryHeaderColor: secondaryHeaderColor,
    toggleableActiveColor: toggleableActiveColor,
    appBarTheme: appBarTheme,
    bottomAppBarColor: bottomAppBarColor,
    dividerColor: dividerColor,
    disabledColor: disabledColor,
    backgroundColor: backgroundColor,
    canvasColor: canvasColor,
    cardColor: cardColor,
    dialogBackgroundColor: dialogBackgroundColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    errorColor: errorColor,
    iconTheme: const IconThemeData(color: kBodyTextColorLight),
    primaryIconTheme: const IconThemeData(color: primaryColorLight),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: kBodyTextColorLight),
      bodyText2: const TextStyle(color: kBodyTextColorLight),
      headline4: const TextStyle(color: kTitleTextLightColor, fontSize: 32),
      headline1: const TextStyle(color: kTitleTextLightColor, fontSize: 80),
    ),
    colorScheme: const ColorScheme.light(
      secondary: secondaryHeaderColor,
    ).copyWith(secondary: kAccentLightColor),
  );
}

// Dark Them
ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    primaryColor: darkPrimaryColor,
    primaryColorDark: darkPrimaryColorDark,
    primaryColorLight: darkPrimaryColorLight,
    secondaryHeaderColor: darkSecondaryHeaderColor,
    toggleableActiveColor: darkToggleableActiveColor,
    appBarTheme: darkAppBarTheme,
    bottomAppBarColor: darkBottomAppBarColor,
    dividerColor: darkDividerColor,
    disabledColor: darkDisabledColor,
    backgroundColor: darkBackgroundColor,
    canvasColor: darkCanvasColor,
    cardColor: darkCardColor,
    dialogBackgroundColor: darkDialogBackgroundColor,
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    errorColor: darkErrorColor,
    iconTheme: const IconThemeData(color: kBodyTextColorDark),
    primaryIconTheme: const IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: kBodyTextColorDark),
      bodyText2: const TextStyle(color: kBodyTextColorDark),
      headline4: const TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      headline1: const TextStyle(color: kTitleTextDarkColor, fontSize: 80),
    ),
    colorScheme: const ColorScheme.light(
      secondary: darkSecondaryHeaderColor,
      surface: kSurfaceDarkColor,
    ).copyWith(secondary: kAccentDarkColor),
  );
}

AppBarTheme appBarTheme =
    const AppBarTheme(color: appBarThemeColor, elevation: 0);
AppBarTheme darkAppBarTheme =
    const AppBarTheme(color: darkAppBarThemeColor, elevation: 0);
