import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  // I GREEN COLORS
  static const Color liteWhite = Color(0xFFe2e4e3);
  static const Color litePink = Color(0xFFeacbea);
  static const Color liteBlack = Color(0xf4f2ff);
  static const Color lite = Color(0xFFF4F2FF);
  static const Color liteGray = Color(0xffe0e0e0);
  static const Color liteBrown = Color(0xFFD6976C);
  static const Color liteBlue3 = Color(0xFFabdce3);
  static const Color screenBackground = Color(0xFFEDEBF6);
  static const Color liteBlue = Color(0xFF627981);
  static const Color liteBlue97 = Color(0xFF449397);
  static const Color grey = Color(0xff9E9E9E);
  static const Color bottomTabsLabelInActiveColor = Color(0xff808895);
  static const Color radioButtonColor = Color(0xff00d1c0);
  static const Color successShade4 = Color(0xFF98CCD0);
  static const Color redShade1 = Color(0xFFB47275);
  static const Color purple1 = Color(0xFFB475B9);
  static const Color corrosion = Color(0xFF4E567E);
  static const Color liteBlue2 = Color(0xFFcc682a);
  static const Color liteYellow = Color(0xFFe9d7a5);
  static const Color profileColor = Color(0xFFEDEBF6);
  static const Color lableColor90 = Color(0xE6252525);
  static const Color lableColor = Color(0x4D252525);
  static const Color primaryColor = Color(0xffedecf6);
  static const Color secondaryColor = Color(0xff89bc3a);
  static const Color appColor = Color(0xfff7faff);
  static const Color textColor = Color(0xcc252525);
  static const Color labelColor = Color(0x4D252525);
  static const Color labelColor90 = Color(0xE6252525);
  static const Color inputBorderColor = Color(0x33252525);
  static const Color appBlack = Color(0xE6252525);
  static const Color mateGreen = Color(0xff1ecd86);
  static const Color successColour = Color(0xff89bc3a);
  static const Color tabGrey = Color(0xfff4f4f4);
  static const Color tabOrange = Color(0xfff88906);
  static const Color selectedOrange = Color(0xfffaf7f3);
  static const Color selectedDealer = Color(0xfffffefa);
  static const Color subTitleOrange = Color(0xfffff7ca);
  static const Color red = Color(0xfffa5364);
  static const Color bgBlue = Color(0xfff0f6ff);
  static const Color bgPink = Color(0xfffff8f0);
  static const Color bgGreen = Color(0xfffafff3);
  static const Color yellow = Color(0xffffd607);
  static const Color lightOrange = Color(0xfffbf6d8);
  static const Color borderShadow = Color(0xffebebeb);
  static const Color hintColor = Color(0xff9E9E9E);
  static const Color borderColor = Color(0x33252525);

  static const Color labelColor70 = Color(0xb3252525);
  static const Color labelColor50 = Color(0x80252525);
  static const Color labelColor80 = Color(0xCC252525);
  static const Color purple = Color(0xFF7C51FD);
  static const Color maroon = Color(0xFFF1CFC9);
  static const Color skyBlue = Color(0xFF06B1BB);
  static const Color cancelBorder = Color(0xFFD9D9D9);
  static const Color cancel = Color(0xFFFFFFFF);
  static const Color borderLightGrey = Color(0xffF5F5F5);
  static const Color borderLineLightGrey = Color(0xffD3D3D3);
  static const Color dividerColor = Color(0x1A000000);
  static const Color front2 = Color(0xff1ecd86);
  static const Color buttonBlueColor = Color(0xFF0F4EAD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color borderShade1 = Color(0x33252525);
  static const Color borderShade2 = Color(0xFF9EB2C4);
  static const Color borderShade3 = Color(0xFFF6F6F6);

  static const Color appCyanColor = Colors.cyan;
  static const Color appRedColor =  Colors.red;
  static const Color appBlueColor = Colors.blue;
  static const Color appgreenColor = Colors.green;
  static const Color appGreyColor = Colors.grey;
  static const Color appYellowColor = Colors.yellow;
  static const Color appPurpleColor = Colors.purple;
  static const Color appOrangeColor = Colors.orange;
  static const Color appDeepPurpleColor = Colors.deepPurple;


}

class Pages {
  static const Gradient backgroundGradient = LinearGradient(
      stops: [0.6, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: backgroundGradientColor);
  static const List<Color> backgroundGradientColor = [
    Color(0xff5D0557),
    Color(0xff140034)
  ];
}

class FormThemes {
  static const Color appTheme = Color(0xff9cb533);
  static const Color appLabelColor = Color(0xff202020);
  static const Color appHeaderColor = Color(0xff9e7d49);
  static const Widget SpaceDivider = SizedBox(height: 20.0);
  static const Color inputBorderColor = Color(0x33252525);

  static const TextStyle formHeaderStyle = TextStyle(
      fontSize: 20.0, color: Color(0xff202020), fontWeight: FontWeight.bold);

  // Textinput
  static const Color labelColor = Colors.white;
  static const BorderRadius inputBorderRadius =
      BorderRadius.all(Radius.circular(8.0));

  static const Map<String, OutlineInputBorder> inputOutlineBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    )
  };

  static const BorderRadius inputLeftBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));

  static const Map<String, OutlineInputBorder> inputLeftOutlineBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    )
  };

  static const BorderRadius inputRightBorderRadius = BorderRadius.only(
      topRight: Radius.circular(10), bottomRight: Radius.circular(10));

  static const Map<String, OutlineInputBorder> customRightDropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    )
  };

  // Buttons
  static MaterialStateProperty<Color> Function(Color btnBGColor) buttonBgColor =
      (btnBGColor) => MaterialStateProperty.all<Color>(btnBGColor);
  static MaterialStateProperty<Color> Function(Color btnFGColor) buttonFgColor =
      (btnFGColor) => MaterialStateProperty.all<Color>(btnFGColor);

  // Text buttons
  static MaterialStateProperty<TextStyle> Function({Color textColor})
      textButtonStyle = ({textColor = Colors.white}) =>
          MaterialStateProperty.all<TextStyle>(TextStyle(color: textColor));

  // Form input
  static const Color formLabelColor = appLabelColor;
  static const Color formInputColor = appTheme;

  // Form Radio
  static const Color formRadioSelectedColor = appTheme;
  static const Color formRadioUnSelectedColor = Color(0xffF1F6FB);
  static MaterialStateProperty<Color> formRadioSelectedLabelColor =
      MaterialStateProperty.all<Color>(Colors.white);
  static MaterialStateProperty<Color> formRadioUnSelectedLabelColor =
      MaterialStateProperty.all<Color>(appLabelColor);

  // Form Dropdown
  static const Color formDropdownBorderColor = Color(0xffF5F5F5);
  static const Map<String, OutlineInputBorder> formDropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    )
  };

  // Dropdown
  static const Color dropdownBorderColor = Color(0xff772D82);
  static const Map<String, OutlineInputBorder> dropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    )
  };

  // Form checkbox
  static Color checkBoxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return Color(0xff34C759);
    }
    return Color(0xffD4D4D4);
  }

  // Gradient Buttons
  static const Gradient successBtnGradient = LinearGradient(
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: successBtnGradientColor);
  static const List<Color> successBtnGradientColor = [
    Color(0xff34C759),
    Color(0xff00711D)
  ];

  // Danger gradient
  static const Gradient dangerBtnGradient = LinearGradient(
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: dangerBtnGradientColor);
  static const List<Color> dangerBtnGradientColor = [
    Color(0xffFF3737),
    Color(0xffBE0000)
  ];

  // Stupid designer
  static const Gradient pinkBtnGradient = LinearGradient(
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: pinkBtnGradientColor);
  static const List<Color> pinkBtnGradientColor = [
    Color(0xffF9468E),
    Color(0xffCB0052)
  ];

  // Stupid designer
  static const Gradient warningBtnGradient = LinearGradient(
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: warningBtnGradientColor);
  static const List<Color> warningBtnGradientColor = [
    Color(0xffFCDE41),
    Color(0xffFDB107)
  ];

  static const Gradient disableBtnGradient = LinearGradient(
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: disableBtnGradientColor);
  static const List<Color> disableBtnGradientColor = [
    Color(0xffB0B3C4),
    Color(0xff808895)
  ];





}
