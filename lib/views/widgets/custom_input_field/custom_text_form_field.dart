part of 'input_field.dart';

//InputDecoration
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.validator,
    required this.maxLength,
    required this.keyboardType,
    required this.autofocus,
    required this.controller,
    required this.onChange,
    required this.inputFormatters,
    this.enabledBorder,
    this.hintTextForEdit,
    super.key,
  });

  /// Input validator function
  final String? Function(String?)? validator;

  ///maxLength
  final int? maxLength;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Autofocus
  final bool autofocus;

  /// Input controller
  final TextEditingController? controller;

  /// Input on input submitted
  final void Function(String)? onChange;

  ///input Formatters
  final List<TextInputFormatter>? inputFormatters;

  ///enabled Border
  final InputBorder? enabledBorder;

  ///hint Text For Edit
  final String? hintTextForEdit;

  @override
  Widget build(BuildContext context) => TextFormField(
        enableSuggestions: false,
        autocorrect: false,
        validator: validator,
        cursorColor: Theme.of(context).color.mainText,
        cursorWidth: 1.5,
        textAlignVertical: TextAlignVertical.top,
        decoration: buildInputDecoration(context),
        style: Theme.of(context).textTheme.bodyMedium,
        maxLength: maxLength,
        keyboardType: keyboardType,
        autofocus: autofocus,
        controller: controller,
        onChanged: onChange,
        inputFormatters: inputFormatters,
      );

  ///InputDecoration
  InputDecoration buildInputDecoration(BuildContext context) => InputDecoration(
        filled: true,
        fillColor: Theme.of(context).color.filedFillingColor,
        labelText: hintTextForEdit ?? '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: hintTextForEdit != null
            ? Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).color.configureTextColor, fontSize: 16)
            : Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Theme.of(context).color.mainText),
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).color.mainButton,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).color.filedDisabledBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).color.errorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).color.errorColor,
          ),
        ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).color.mainButton,
              ),
            ),
      );
}
