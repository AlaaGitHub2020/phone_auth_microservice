import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/widgets/custom_input_field/input_field.dart';

///Edit Family
class EditFamily extends StatelessWidget {
  ///Constructor
  const EditFamily({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: InputField(
          onChange: (String value) {},
          hint: '',
          keyboardType: TextInputType.text,
          maxLength: 18,
          initialValue: '',
          hintTextForEdit: S.current.yourFamily,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).color.disableButton,
            ),
          ),
// inputFormatters: [maskFormatter],
        ),
      );
}
