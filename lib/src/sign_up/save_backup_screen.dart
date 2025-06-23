import 'package:kaonic/data/models/user_model.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/theme/assets.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:flutter/material.dart';

class SaveBackupScreen extends StatelessWidget {
  const SaveBackupScreen({super.key, required UserModel user}) : _user = user;

  final UserModel _user;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ScreenContainer(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).labelHelloTo,
                      style:
                          TextStyles.text36Bold.copyWith(color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Image.asset(
                        Assets.imageLogo,
                        width: 44.w,
                        height: 44.w,
                      ),
                    ),
                    Text(
                      S.of(context).labelExclamationSign,
                      style:
                          TextStyles.text36Bold.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 17.h, horizontal: 25.w),
                    margin: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.grey3),
                      color: AppColors.grey3.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        _backupTextRow(
                            title: S.of(context).labelUsername,
                            text: _user.username),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: _backupTextRow(
                              title: S.of(context).labelAddress,
                              text: _userAddress(_user.key)),
                        ),
                        Text(
                          S.of(context).labelPleaseSaveThisFile,
                          style: TextStyles.text18
                              .copyWith(color: AppColors.grey3),
                        ),
                      ],
                    )),
                MainButton(
                  label: S.of(context).labelContinue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _userAddress(String addressHex) {
    return addressHex.isEmpty
        ? ''
        : addressHex.length < 8
            ? addressHex.substring(4)
            : addressHex.substring(addressHex.length - 10);
  }

  Row _backupTextRow({required String title, required String text}) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(title,
              style: TextStyles.text18.copyWith(color: AppColors.yellow)),
        ),
        Flexible(
            child: Text(
          text,
          style: TextStyles.text18.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
