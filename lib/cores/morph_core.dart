import 'package:flutter/material.dart';

/// Morph wallet routes.
class MorphRoute {
  static const onboarding = '/onboarding_screen';
  static const createWallet = '/create_wallet_screen';
  static const importWallet = '/import_wallet_screen';
}

/// Morph images asset
class MorphImage {
  static const pattern = 'assets/images/pattern.png';
}

/// Morph wallet keys.
class MorphKey {
  static final homeKey = GlobalKey();
  static const onboardingKey = Key('__onboarding_screen__');
  static const createWalletKey = Key('__create_wallet_screen__');
  static const importWalletKey = Key('__import_wallet_screen__');
}

/// Morph wallet colors pallet.
class MorphColor {
  static const Color darkColor = Color(0xFF232323);
  static const Color secondaryDarkColor = Color(0xFF353535);
  static const Color whiteColor = Colors.white;
  static const Color primaryColor = Color(0xFF8B50F5);
  static const Color errorColor = Color(0xFFF13440);
  static const Color yellowColor = Color(0xFFDCA73C);
  static const Color darkYellowColor = Color(0xFF3F3727);
  static const Color pinkColor = Color(0xFFF5509F);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color darkGreyColor = Color(0xFF4F4F4F);
  static const Color greenColor = Color(0xFF34F174);
}

/// Default Morph wallet theme.
class MorphTheme {
  /// Apply dark mode.
  static get applyDarkMode {
    final originalTextTheme = ThemeData.dark().textTheme;

    return ThemeData().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MorphColor.darkColor,
      primaryColor: MorphColor.primaryColor,
      errorColor: MorphColor.errorColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: const IconThemeData(
        color: MorphColor.whiteColor,
        size: 23.0,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: MorphColor.whiteColor),
        backgroundColor: MorphColor.darkColor,
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
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: MorphColor.whiteColor,
            ),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: MorphColor.secondaryDarkColor,
        thickness: 1.5,
      ),
      textTheme: originalTextTheme.apply(
        fontFamily: 'Inter',
        bodyColor: MorphColor.whiteColor,
      ),
    );
  }
}
