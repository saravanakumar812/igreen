import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../api_config/ApiUrl.dart';
import 'theme.dart';

class TextInput extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final String? imagePath;
  final bool obscureText;
  final bool margin;

  final bool isEntryField;
  final bool withImage;
  final bool isSelected;
  final bool isMistake;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final bool isReadOnly;
  final bool enableInteractiveSelection;
  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final FocusNode? focusNode;

  final Color hintTextColor;
  final Color labelTextColor;

  const TextInput({
    required this.label,
    required this.onTextChange,
    this.obscureText = false,
    this.isReadOnly = false,
    this.withImage = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.imagePath,
    this.margin = true,
    this.enableInteractiveSelection = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.textInputType,
    this.icon,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.labelColor90,
    this.labelTextColor = AppTheme.borderLightGrey,
    this.focusNode,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool showPassword = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.hintText!.split('\n');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      //color: widget.isEntryField ? AppTheme.appColor : Colors.white,
      margin: widget.margin
          ? EdgeInsets.fromLTRB(12, 14, 12, 0)
          : EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.isEntryField
                ? Material(
              borderRadius:
              const BorderRadius.all(Radius.circular(4.0)),
             color: AppTheme.appColor,
              child: TextFormField(
                focusNode: widget.focusNode,
                autofocus: false,
                autocorrect: false,
                enableSuggestions: false,
                onTap: widget.onPressed,
                enableInteractiveSelection:
                widget.enableInteractiveSelection,
                readOnly: widget.isReadOnly ? true : false,
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.done,
                textCapitalization: widget.isCapital
                    ? TextCapitalization.characters
                    : TextCapitalization.words,
                minLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                maxLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                inputFormatters: widget.isCapsNumeric
                    ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[0-9A-Z.]")),
                ]
                    : widget.textInputType! == TextInputType.number ||
                    widget.textInputType! == TextInputType.phone
                    ? [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[!@#$%^&*(),?":{}|<>]')),
                  LengthLimitingTextInputFormatter(10)
                ]
                    : [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'#[^.]')),
                  // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),

                  // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
                ],
                maxLength: widget.MaxLength,
                onChanged: widget.onTextChange,
                controller: widget.controller,
                style: TextStyle(
                    letterSpacing: 0.2,
                    color: widget.textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.label,
                  counter: Offstage(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                      color: widget.controller.isNull
                          ? AppTheme.textColor
                          : widget.controller!.value.text.isEmpty
                          ? AppTheme.textColor
                          : AppTheme.labelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppTheme.labelColor,
                  ),
                  errorText: widget.errorText,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: widget.contentPaddingV.isNull
                          ? 10.0
                          : widget.contentPaddingV!),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: BorderSide(width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                  suffixIcon: widget.obscureText
                      ? IconButton(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.0),
                    color: Color(0xff252525),
                    onPressed: widget.onPressed,
                    icon: widget.sufficIcon == null
                        ? const Icon(Icons.keyboard_arrow_down)
                        : widget.sufficIcon!,
                  )
                      : null,
                ).copyWith(
                  focusedBorder:
                  FormThemes.inputOutlineBorder['focusedBorder'],
                  border: FormThemes.inputOutlineBorder['border'],
                  errorBorder:
                  FormThemes.inputOutlineBorder['errorBorder'],
                  disabledBorder:
                  FormThemes.inputOutlineBorder['disabledBorder'],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                ),
              ),
            )
                : widget.demoCar
                ? InkWell(
              onTap: widget.onPressed,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? AppTheme.selectedOrange
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5.5),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lines[0],
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        lines[1],
                        style: TextStyle(
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : widget.withImage
                ? Container(
              color: Colors.white,
              width: width,
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: width * 0.60,
                    child: Material(
                      color: widget.isSelected
                          ? AppTheme.selectedOrange
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        readOnly: true,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: widget.MaxLength,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        onTap: widget.onPressed,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final textLines =
                                newValue.text.split('\n');
                                if (textLines.length > 1 &&
                                    textLines[1].isNotEmpty) {
                                  final newText =
                                  textLines.join('\n');
                                  final newValue = TextEditingValue(
                                    text: newText,
                                    selection:
                                    TextSelection.collapsed(
                                        offset: newText.length),
                                  );
                                  _controller.value = newValue;
                                  setState(() {});
                                  return newValue;
                                }
                                return newValue;
                              }),
                        ],
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                              color: widget.isSelected
                                  ? Colors.deepOrangeAccent
                                  : Colors.black),
                          errorText: widget.errorText,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0),
                        ).copyWith(
                          border: FormThemes
                              .inputOutlineBorder['border'],
                          errorBorder:
                          FormThemes.inputOutlineBorder[
                          'errorBorder'],
                          disabledBorder:
                          FormThemes.inputOutlineBorder[
                          'disabledBorder'],
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5.5),
                            borderSide: BorderSide(
                              color: widget.isSelected
                                  ? Colors.white
                                  : Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    child: Image.network(
                      "${ApiUrl.baseUrl}category_icons/${widget.imagePath}" ??
                          "",
                      fit: BoxFit.contain,
                      width: width * 0.1,
                      height: height * 0.2,
                    ),
                  ),
                ],
              ),
            )
                : Container(
              height: 50,
              child: Material(
                color: widget.isSelected
                    ? AppTheme.selectedOrange
                    : Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 2,
                  maxLength: widget.MaxLength,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: widget.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  onTap: widget.onPressed,
                  inputFormatters: [
                    TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                          final textLines =
                          newValue.text.split('\n');
                          if (textLines.length > 1 &&
                              textLines[1].isNotEmpty) {
                            final newText = textLines.join('\n');
                            final newValue = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                            _controller.value = newValue;
                            setState(() {});
                            return newValue;
                          }
                          return newValue;
                        }),
                  ],
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: widget.isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.black),
                    errorText: widget.errorText,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ).copyWith(
                    border:
                    FormThemes.inputOutlineBorder['border'],
                    errorBorder: FormThemes
                        .inputOutlineBorder['errorBorder'],
                    disabledBorder: FormThemes
                        .inputOutlineBorder['disabledBorder'],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: BorderSide(
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

class Button extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  Button({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(8.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), side: borderColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  Button2({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(
          color: Colors.redAccent, borderRadius: BorderRadius.circular(8.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), side: borderColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class AppSnackBar {
  String title;
  String message;

  AppSnackBar({required this.title, required this.message}) {
    print("HERE");
  }

  AppSnackBar.error({
    required this.message,
    this.title = "Error",
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.redAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.success({required this.message, this.title = "Success"}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.greenAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.warning({required this.title, required this.message}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.orangeAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }
}



class TextInput1 extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final String? imagePath;
  final bool obscureText;
  final bool margin;

  final bool isEntryField;
  final bool withImage;
  final bool isSelected;
  final bool isMistake;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final bool isReadOnly;
  final bool enableInteractiveSelection;
  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final FocusNode? focusNode;

  final Color hintTextColor;
  final Color labelTextColor;

  const TextInput1({
    required this.label,
    required this.onTextChange,
    this.obscureText = false,
    this.isReadOnly = false,
    this.withImage = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.imagePath,
    this.margin = true,
    this.enableInteractiveSelection = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.textInputType,
    this.icon,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.labelColor90,
    this.labelTextColor = AppTheme.borderLightGrey,
    this.focusNode,
  });

  @override
  State<TextInput1> createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  bool showPassword = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.hintText!.split('\n');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      //color: widget.isEntryField ? AppTheme.appColor : Colors.white,
      margin: widget.margin
          ? EdgeInsets.fromLTRB(12, 14, 12, 0)
          : EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.isEntryField
                ? Material(
              borderRadius:
              const BorderRadius.all(Radius.circular(4.0)),
              color: AppTheme.appColor,
              child: TextFormField(
                focusNode: widget.focusNode,
                autofocus: false,
                autocorrect: false,
                enableSuggestions: false,
                onTap: widget.onPressed,
                enableInteractiveSelection:
                widget.enableInteractiveSelection,
                readOnly: widget.isReadOnly ? true : false,
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.done,
                textCapitalization: widget.isCapital
                    ? TextCapitalization.characters
                    : TextCapitalization.words,
                minLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                maxLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                inputFormatters: widget.isCapsNumeric
                    ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[0-9A-Z]")),
                ]
                    : widget.textInputType! == TextInputType.number ||
                    widget.textInputType! == TextInputType.phone
                    ? [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                  LengthLimitingTextInputFormatter(10)
                ]
                    : [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'#')),
                  // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),

                  // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
                ],
                maxLength: widget.MaxLength,
                onChanged: widget.onTextChange,
                controller: widget.controller,
                style: TextStyle(
                    letterSpacing: 0.2,
                    color: widget.textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.label,
                  counter: Offstage(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                      color: widget.controller.isNull
                          ? AppTheme.textColor
                          : widget.controller!.value.text.isEmpty
                          ? AppTheme.textColor
                          : AppTheme.labelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppTheme.labelColor,
                  ),
                  errorText: widget.errorText,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: widget.contentPaddingV.isNull
                          ? 10.0
                          : widget.contentPaddingV!),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: BorderSide(width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                  suffixIcon: widget.obscureText
                      ? IconButton(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.0),
                    color: Color(0xff252525),
                    onPressed: widget.onPressed,
                    icon: widget.sufficIcon == null
                        ? const Icon(Icons.filter_alt)
                        : widget.sufficIcon!,
                  )
                      : null,
                ).copyWith(
                  focusedBorder:
                  FormThemes.inputOutlineBorder['focusedBorder'],
                  border: FormThemes.inputOutlineBorder['border'],
                  errorBorder:
                  FormThemes.inputOutlineBorder['errorBorder'],
                  disabledBorder:
                  FormThemes.inputOutlineBorder['disabledBorder'],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                ),
              ),
            )
                : widget.demoCar
                ? InkWell(
              onTap: widget.onPressed,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? AppTheme.selectedOrange
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5.5),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lines[0],
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        lines[1],
                        style: TextStyle(
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : widget.withImage
                ? Container(
              color: Colors.white,
              width: width,
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: width * 0.60,
                    child: Material(
                      color: widget.isSelected
                          ? AppTheme.selectedOrange
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        readOnly: true,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: widget.MaxLength,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        onTap: widget.onPressed,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final textLines =
                                newValue.text.split('\n');
                                if (textLines.length > 1 &&
                                    textLines[1].isNotEmpty) {
                                  final newText =
                                  textLines.join('\n');
                                  final newValue = TextEditingValue(
                                    text: newText,
                                    selection:
                                    TextSelection.collapsed(
                                        offset: newText.length),
                                  );
                                  _controller.value = newValue;
                                  setState(() {});
                                  return newValue;
                                }
                                return newValue;
                              }),
                        ],
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                              color: widget.isSelected
                                  ? Colors.deepOrangeAccent
                                  : Colors.black),
                          errorText: widget.errorText,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0),
                        ).copyWith(
                          border: FormThemes
                              .inputOutlineBorder['border'],
                          errorBorder:
                          FormThemes.inputOutlineBorder[
                          'errorBorder'],
                          disabledBorder:
                          FormThemes.inputOutlineBorder[
                          'disabledBorder'],
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5.5),
                            borderSide: BorderSide(
                              color: widget.isSelected
                                  ? Colors.white
                                  : Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    child: Image.network(
                      "${ApiUrl.baseUrl}category_icons/${widget.imagePath}" ??
                          "",
                      fit: BoxFit.contain,
                      width: width * 0.1,
                      height: height * 0.2,
                    ),
                  ),
                ],
              ),
            )
                : Container(
              height: 50,
              child: Material(
                color: widget.isSelected
                    ? AppTheme.selectedOrange
                    : Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 2,
                  maxLength: widget.MaxLength,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: widget.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  onTap: widget.onPressed,
                  inputFormatters: [
                    TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                          final textLines =
                          newValue.text.split('\n');
                          if (textLines.length > 1 &&
                              textLines[1].isNotEmpty) {
                            final newText = textLines.join('\n');
                            final newValue = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                            _controller.value = newValue;
                            setState(() {});
                            return newValue;
                          }
                          return newValue;
                        }),
                  ],
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: widget.isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.black),
                    errorText: widget.errorText,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ).copyWith(
                    border:
                    FormThemes.inputOutlineBorder['border'],
                    errorBorder: FormThemes
                        .inputOutlineBorder['errorBorder'],
                    disabledBorder: FormThemes
                        .inputOutlineBorder['disabledBorder'],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: BorderSide(
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}



class TextInput2 extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final String? imagePath;
  final bool obscureText;
  final bool margin;

  final bool isEntryField;
  final bool withImage;
  final bool isSelected;
  final bool isMistake;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final bool isReadOnly;
  final bool enableInteractiveSelection;
  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final FocusNode? focusNode;

  final Color hintTextColor;
  final Color labelTextColor;

  const TextInput2({
    this.label,
    required this.onTextChange,
    this.obscureText = false,
    this.isReadOnly = false,
    this.withImage = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.imagePath,
    this.margin = true,
    this.enableInteractiveSelection = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.textInputType,
    this.icon,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.labelColor90,
    this.labelTextColor = AppTheme.borderLightGrey,
    this.focusNode,
  });

  @override
  State<TextInput2> createState() => _TextInput2State();
}

class _TextInput2State extends State<TextInput2> {
  bool showPassword = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.hintText!.split('\n');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      //color: widget.isEntryField ? AppTheme.appColor : Colors.white,
      margin: widget.margin
          ? EdgeInsets.fromLTRB(12, 14, 12, 0)
          : EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.isEntryField
                ? Material(
              borderRadius:
              const BorderRadius.all(Radius.circular(4.0)),
              color: Colors.white,
              child: TextFormField(
                focusNode: widget.focusNode,
                autofocus: false,
                autocorrect: false,
                enableSuggestions: false,
                onTap: widget.onPressed,
                enableInteractiveSelection:
                widget.enableInteractiveSelection,
                readOnly: widget.isReadOnly ? true : false,
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.done,
                textCapitalization: widget.isCapital
                    ? TextCapitalization.characters
                    : TextCapitalization.words,
                minLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                maxLines:
                widget.textInputType == TextInputType.multiline
                    ? 3
                    : 1,
                inputFormatters: widget.isCapsNumeric
                    ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[0-9A-Z.]")),
                ]
                    : widget.textInputType! == TextInputType.number ||
                    widget.textInputType! == TextInputType.phone
                    ? [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[!@#$%^&*(),?":{}|<>]')),
                  LengthLimitingTextInputFormatter(10)
                ]
                    : [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'#[^.]')),
                  // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),

                  // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
                ],
                maxLength: widget.MaxLength,
                onChanged: widget.onTextChange,
                controller: widget.controller,
                style: TextStyle(
                    letterSpacing: 0.2,
                    color: widget.textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.label,
                  counter: Offstage(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                      color: widget.controller.isNull
                          ? AppTheme.textColor
                          : widget.controller!.value.text.isEmpty
                          ? AppTheme.textColor
                          : AppTheme.labelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppTheme.labelColor,
                  ),
                  errorText: widget.errorText,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: widget.contentPaddingV.isNull
                          ? 10.0
                          : widget.contentPaddingV!),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: BorderSide(width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                  suffixIcon: widget.obscureText
                      ? IconButton(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.0),
                    color: Color(0xff252525),
                    onPressed: widget.onPressed,
                    icon: widget.sufficIcon == null
                        ? const Icon(Icons.keyboard_arrow_down)
                        : widget.sufficIcon!,
                  )
                      : null,
                ).copyWith(
                  focusedBorder:
                  FormThemes.inputOutlineBorder['focusedBorder'],
                  border: FormThemes.inputOutlineBorder['border'],
                  errorBorder:
                  FormThemes.inputOutlineBorder['errorBorder'],
                  disabledBorder:
                  FormThemes.inputOutlineBorder['disabledBorder'],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5),
                    borderSide: widget.isMistake
                        ? BorderSide(
                        color: Colors.deepOrangeAccent, width: 1.0)
                        : BorderSide(
                        color: Color(0x4d252525), width: 1.0),
                  ),
                ),
              ),
            )
                : widget.demoCar
                ? InkWell(
              onTap: widget.onPressed,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? AppTheme.selectedOrange
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5.5),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lines[0],
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        lines[1],
                        style: TextStyle(
                            color: widget.isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : widget.withImage
                ? Container(
              color: Colors.white,
              width: width,
              height: 70,
              child: Row(
                children: [
                  Container(
                    width: width * 0.60,
                    child: Material(
                      color: widget.isSelected
                          ? AppTheme.selectedOrange
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        readOnly: true,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: widget.MaxLength,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        onTap: widget.onPressed,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final textLines =
                                newValue.text.split('\n');
                                if (textLines.length > 1 &&
                                    textLines[1].isNotEmpty) {
                                  final newText =
                                  textLines.join('\n');
                                  final newValue = TextEditingValue(
                                    text: newText,
                                    selection:
                                    TextSelection.collapsed(
                                        offset: newText.length),
                                  );
                                  _controller.value = newValue;
                                  setState(() {});
                                  return newValue;
                                }
                                return newValue;
                              }),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                              color: widget.isSelected
                                  ? Colors.deepOrangeAccent
                                  : Colors.black),
                          errorText: widget.errorText,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0),
                        ).copyWith(
                          border: FormThemes
                              .inputOutlineBorder['border'],
                          errorBorder:
                          FormThemes.inputOutlineBorder[
                          'errorBorder'],
                          disabledBorder:
                          FormThemes.inputOutlineBorder[
                          'disabledBorder'],
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(5.5),
                            borderSide: BorderSide(
                              color: widget.isSelected
                                  ? Colors.white
                                  : Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    child: Image.network(
                      "${ApiUrl.baseUrl}category_icons/${widget.imagePath}" ??
                          "",
                      fit: BoxFit.contain,
                      width: width * 0.1,
                      height: height * 0.2,
                    ),
                  ),
                ],
              ),
            )
                : Container(
              height: 50,
              child: Material(
                color: widget.isSelected
                    ? AppTheme.selectedOrange
                    : Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  minLines: 1,
                  maxLines: 2,
                  maxLength: widget.MaxLength,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: widget.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  onTap: widget.onPressed,
                  inputFormatters: [
                    TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                          final textLines =
                          newValue.text.split('\n');
                          if (textLines.length > 1 &&
                              textLines[1].isNotEmpty) {
                            final newText = textLines.join('\n');
                            final newValue = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                            _controller.value = newValue;
                            setState(() {});
                            return newValue;
                          }
                          return newValue;
                        }),
                  ],
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: widget.isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.black),
                    errorText: widget.errorText,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ).copyWith(
                    border:
                    FormThemes.inputOutlineBorder['border'],
                    errorBorder: FormThemes
                        .inputOutlineBorder['errorBorder'],
                    disabledBorder: FormThemes
                        .inputOutlineBorder['disabledBorder'],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: BorderSide(
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}