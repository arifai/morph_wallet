import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';

/// Default Morph wallet theme.
class MorphTheme {
  /// Apply dark mode.
  static get applyDarkMode {
    final originalTextTheme = ThemeData.dark().textTheme;

    return ThemeData().copyWith(
      hoverColor: Colors.transparent,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MorphColor.darkColor,
      primaryColor: MorphColor.primaryColor,
      errorColor: MorphColor.errorColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      listTileTheme: const ListTileThemeData(style: ListTileStyle.list),
      iconTheme: const IconThemeData(
        color: MorphColor.whiteColor,
        size: 23.0,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: MorphColor.greyColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 3.5),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: MorphColor.secondaryDarkColor,
        ),
        labelStyle: const TextStyle(
          color: MorphColor.whiteColor,
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: MorphColor.darkColor,
        actionsIconTheme: IconThemeData(color: MorphColor.whiteColor),
        iconTheme: IconThemeData(color: MorphColor.whiteColor),
        titleTextStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          color: MorphColor.whiteColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor:
              MaterialStateProperty.all(MorphColor.secondaryDarkColor),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          // ignore: fixme
          // FIXME: I don't know this isn't work
          // textStyle: MaterialStateProperty.all(
          //   const TextStyle(
          //     fontSize: 17.0,
          //     fontFamily: 'Inter',
          //     fontWeight: FontWeight.bold,
          //     color: MorphColor.secondaryDarkColor,
          //   ),
          // ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all(MorphColor.primaryColor),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          // ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: MorphColor.whiteColor,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
        hintStyle: const TextStyle(
          color: MorphColor.greyColor,
          fontFamily: 'Inter',
        ),
        iconColor: MorphColor.greyColor,
        suffixIconColor: MorphColor.greyColor,
        fillColor: MorphColor.secondaryDarkColor,
        suffixStyle: const TextStyle(color: MorphColor.greyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: MorphColor.primaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: MorphColor.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: MorphColor.errorColor),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: MorphColor.secondaryDarkColor,
        thickness: 1.5,
        space: 1,
      ),
      textTheme: originalTextTheme.apply(
        fontFamily: 'Inter',
        bodyColor: MorphColor.whiteColor,
      ),
    );
  }
}
