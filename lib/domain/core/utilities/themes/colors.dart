part of 'theme_data_extension.dart';

/// Colors theme extension
class ThemeColors extends ThemeExtension<ThemeColors> {
  /// Default constructor
  const ThemeColors({
    required this.mainText,
    required this.secondText,
    required this.mainButton,
    required this.disableButton,
    required this.mainBackground,
    required this.secondBackground,
    required this.errorColor,
    required this.filedFillingColor,
    required this.filedDisabledBorderColor,
    required this.bottomNavigationBarItemActiveColor,
    required this.titleTextColor,
    required this.avatarColor,
    required this.configureTextColor,
    required this.bottomSheetTextColor,
  });

  final Color mainText;
  final Color secondText;
  final Color mainButton;
  final Color disableButton;
  final Color mainBackground;
  final Color secondBackground;
  final Color errorColor;
  final Color filedFillingColor;
  final Color filedDisabledBorderColor;
  final Color bottomNavigationBarItemActiveColor;
  final Color titleTextColor;
  final Color avatarColor;
  final Color configureTextColor;
  final Color bottomSheetTextColor;

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      mainText: Color.lerp(mainText, other.mainText, t)!,
      secondText: Color.lerp(secondText, other.secondText, t)!,
      mainButton: Color.lerp(mainButton, other.mainButton, t)!,
      disableButton: Color.lerp(disableButton, other.disableButton, t)!,
      mainBackground: Color.lerp(mainBackground, other.mainBackground, t)!,
      secondBackground:
          Color.lerp(secondBackground, other.secondBackground, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      filedFillingColor:
          Color.lerp(filedFillingColor, other.filedFillingColor, t)!,
      filedDisabledBorderColor: Color.lerp(
          filedDisabledBorderColor, other.filedDisabledBorderColor, t)!,
      bottomNavigationBarItemActiveColor: Color.lerp(
          bottomNavigationBarItemActiveColor,
          other.bottomNavigationBarItemActiveColor,
          t)!,
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t)!,
      avatarColor: Color.lerp(avatarColor, other.avatarColor, t)!,
      configureTextColor:
          Color.lerp(configureTextColor, other.configureTextColor, t)!,
      bottomSheetTextColor:
          Color.lerp(bottomSheetTextColor, other.bottomSheetTextColor, t)!,
    );
  }

  @override
  ThemeExtension<ThemeColors> copyWith() {
    throw UnimplementedError();
  }
}
