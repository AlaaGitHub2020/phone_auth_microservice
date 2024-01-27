import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/agreement_text.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/current_step_row.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/phone_number_field.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/registration_text.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/send_code_again_part.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/send_sms_code_btn.dart';

///Auth Page Body
class AuthPageBody extends StatelessWidget {
  ///Constructor
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CurrentStepRow(),
              SizedBox(height: 24),
              RegistrationText(),
              SizedBox(height: 38),
              PhoneNumberField(),
              SendCodeAgainPart(),
              SendSmsCodeBtn(),
              SizedBox(height: 8),
              AgreementText(),
            ],
          ),
        ),
      );
}
