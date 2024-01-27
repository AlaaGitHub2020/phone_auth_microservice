import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/close_btn.dart';
import 'package:phone_auth_microservice/views/widgets/helper_mixin.dart';

///Edit Avatar Button
class EditAvatarBtn extends StatelessWidget with HelperMixin {
  ///Constructor
  const EditAvatarBtn({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: () => showModalBottomSheet(
            clipBehavior: Clip.none,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) => SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: buildBoxDecoration(context),
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    height: 162,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildSelectAPhotoText(context),
                        buildEditFromCameraBtn(context),
                        buildEditFromGalleryBtn(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CloseBtn(),
                ],
              ),
            ),
          ),
      icon: SvgPicture.asset(ViewsConstants.icEdit));

  ///build Edit From Gallery Btn
  TextButton buildEditFromGalleryBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        getLogger().i('photoGallery');
        context.router.pop();
        context.read<HomeUiLogicBloc>().add(
              const HomeUiLogicEvent.updateAvatar(ImageSource.gallery),
            );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).color.disableButton))),
        height: 60,
        child: Text(
          S.current.photoGallery,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  ///build Edit From Camera Btn
  TextButton buildEditFromCameraBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        getLogger().i('camera');
        context.router.pop();
        context.read<HomeUiLogicBloc>().add(
              const HomeUiLogicEvent.updateAvatar(ImageSource.camera),
            );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).color.disableButton))),
        height: 42,
        child: Text(
          S.current.camera,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  ///build Select A Photo Text
  Container buildSelectAPhotoText(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).color.disableButton))),
      height: 42,
      child: Text(
        S.current.selectAPhoto,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).color.bottomSheetTextColor, fontSize: 13),
      ),
    );
  }
}
