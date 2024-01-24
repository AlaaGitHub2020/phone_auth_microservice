import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/widgets/custom_input_field/input_field.dart';
import 'package:phone_auth_microservice/views/widgets/step_number.dart';

///Auth Page
class AuthPage extends StatelessWidget {
  ///Constructor
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            onPressed: () => false,
            icon: SvgPicture.asset(ViewsConstants.icBack)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StepNumber(active: true, stepNumber: '1'),
                    StepNumber(active: false, stepNumber: '2'),
                    StepNumber(active: false, stepNumber: '3'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: Column(
                  children: [
                    Text(
                      S.current.registration,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      S.current.enterYourPhoneNumberToRegister,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 38),
              InputField(
                onChange: (_) {},
                hint: S.current.phoneNumber,
                keyboardType: TextInputType.phone,
                maxLength: 18,
                initialValue: '+7(',
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  S.current.sendSmsCode,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: RichText(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: S.current.byClickingOn,
                    style: Theme.of(context).textTheme.titleSmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: S.current.personalData,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).color.mainButton),
                      ),
                    ],
                  ),
                ),
              ),
              // Text(S.current.byClickingOn),
            ],
          ),
        ),
      ),
    ));
  }
}
