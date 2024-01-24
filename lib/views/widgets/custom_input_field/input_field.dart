import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';

part 'custom_text_form_field.dart';

/// Custom input Field widget
class InputField extends StatefulWidget {
  ///Constructor
  const InputField({
    required this.onChange,
    this.hint,
    this.keyboardType,
    this.autofocus = false,
    this.initialValue,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    super.key,
  });

  /// Input hint
  final String? hint;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Autofocus
  final bool autofocus;

  /// Initial input value
  final String? initialValue;

  /// Input on input submitted
  final ValueChanged<String>? onChange;

  /// Input validator function
  final FormFieldValidator<String?>? validator;

  ///input Formatters
  final List<TextInputFormatter>? inputFormatters;

  ///maxLength
  final int? maxLength;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();
    if ((widget.initialValue ?? '').isNotEmpty) {
      controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Input controller
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        height: 72,
        padding: const EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildHint(context),
            SizedBox(
              height: 46,
              child: CustomTextFormField(
                keyboardType: widget.keyboardType,
                controller: controller,
                maxLength: widget.maxLength,
                onChange: widget.onChange,
                inputFormatters: widget.inputFormatters,
                validator: widget.validator,
                autofocus: widget.autofocus,
              ),
            ),
          ],
        ),
      );

  ///build Hint Text
  Text buildHint(BuildContext context) =>
      Text(widget.hint ?? '', style: Theme.of(context).textTheme.titleMedium);

  ///build Text Form Field
// TextFormField buildTextFormField(BuildContext context) => TextFormField(
//   enableSuggestions: false,
//   autocorrect: false,
//   validator: widget.validator,
//   cursorColor: Theme.of(context).color.mainText,
//   cursorWidth: 1.5,
//   textAlignVertical: TextAlignVertical.top,
//   decoration: buildInputDecoration(context),
//   style: Theme.of(context).textTheme.bodyMedium,
//   maxLength: widget.maxLength,
//   keyboardType: widget.keyboardType,
//   autofocus: widget.autofocus,
//   controller: controller,
//   onChanged: widget.onChange,
//   inputFormatters: widget.inputFormatters,
// );
}
