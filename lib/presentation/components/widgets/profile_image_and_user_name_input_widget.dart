import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/shared/name.dart';
import '../../shared/constants/l10n.dart';
import '../parts/button_for_adding_profile_image.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/text_for_input_explanation.dart';
import '../parts/text_form_field_for_user_name_input.dart';

class ProfileImageAndUserNameInputWidget extends HookWidget {
  final TextEditingController userNameInputController;
  final VoidCallback incrementProgressCounter;
  final String profileImage;
  final void Function() uploadPhotoFromCamera;
  final void Function() uploadPhotoFromGallery;
  const ProfileImageAndUserNameInputWidget({
    super.key,
    required this.userNameInputController,
    required this.incrementProgressCounter,
    required this.profileImage,
    required this.uploadPhotoFromCamera,
    required this.uploadPhotoFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    final isUserNameFilled =
        useState<bool>(userNameInputController.text.isNotEmpty);
    final userNameErrorText = useState<String?>(null);

    void checkUserNameFilled(String text) {
      if (text.length > Name.maxLength) {
        userNameErrorText.value = L10n.userNameErrorText;
        isUserNameFilled.value = false; //trueの状態でmaxLengthをoverする場合もあるので
      } else {
        userNameErrorText.value = null;
        isUserNameFilled.value = text.isNotEmpty;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextForProfileInputExplanation(
            explanationText: L10n.userProfileImageAndNameInputExplanationText),
        const SizedBox(height: 70),
        ButtonForAddingProfileImage(
          isPicturesAdded: profileImage.isNotEmpty,
          takePhoto: uploadPhotoFromCamera,
          pickPhoto: uploadPhotoFromGallery,
          selectedPhoto: profileImage,
        ),
        const SizedBox(height: 70),
        TextFormFieldForUserNameInput(
          controller: userNameInputController,
          onChanged: checkUserNameFilled,
          errorText: userNameErrorText.value,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonForProfileInputNext(
              incrementCounter:
                  profileImage.isNotEmpty && isUserNameFilled.value
                      ? incrementProgressCounter
                      : null,
            )
          ],
        ),
      ],
    );
  }
}
