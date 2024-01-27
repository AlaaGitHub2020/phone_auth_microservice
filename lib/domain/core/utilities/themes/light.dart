part of 'theme_data_extension.dart';

/// Application light theme
ThemeData hotelsExplorationLight = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromRGBO(251, 251, 251, 1),
  fontFamily: 'SF-Pro-Display',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 184, 0, 1),
        disabledBackgroundColor: const Color.fromRGBO(167, 167, 167, 1),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(285, 53)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
  ),
  textTheme: const TextTheme(
    ///for big titles
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 34,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(79, 79, 79, 1),
    ),

    ///for description
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(79, 79, 79, 1),
    ),

    ///For agreement
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: 'SF-Pro-Display',
    ),

    ///for field hints
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(79, 79, 79, 1),
    ),

    ///for agreement
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(167, 167, 167, 1),
    ),

    ///For numbers
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(79, 79, 79, 1),
    ),

    ///For Field text
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(79, 79, 79, 1),
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      fontFamily: 'SF-Pro-Display',
      color: Color.fromRGBO(0, 152, 238, 1),
    ),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    ThemeColors(
      mainText: Color.fromRGBO(79, 79, 79, 1),
      secondText: Color.fromRGBO(167, 167, 167, 1),
      mainButton: Color.fromRGBO(255, 184, 0, 1),
      disableButton: Color.fromRGBO(236, 236, 236, 1),
      mainBackground: Color.fromRGBO(255, 255, 255, 1),
      secondBackground: Color.fromRGBO(246, 246, 246, 1),
      errorColor: Colors.red,
      filedFillingColor: Color.fromRGBO(251, 251, 251, 1),
      filedDisabledBorderColor: Color.fromRGBO(217, 217, 217, 1),
      bottomNavigationBarItemActiveColor: Color.fromRGBO(0, 152, 238, 1),
      titleTextColor: Color.fromRGBO(77, 77, 77, 1),
      avatarColor: Color.fromRGBO(227, 227, 227, 1),
      configureTextColor: Color.fromRGBO(198, 198, 200, 1),
      bottomSheetTextColor: Color.fromRGBO(125, 125, 125, 1),
    ),
  ],
);
