
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:kaonic/src/find_nearby/bloc/find_nearby_bloc.dart';
import 'package:kaonic/src/find_nearby/device_item.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/utils/dialog_util.dart';

class FindNearbyScreen extends StatelessWidget {
  const FindNearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindNearbyBloc(
        communicationService: context.read<KaonicCommunicationService>(),
        userService: context.read<UserService>(),
      ),
      child: Scaffold(
        body: ScreenContainer(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 10.h + MediaQuery.of(context).padding.top,
              bottom: 10.h + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: BackButton(
                          color: Colors.white,
                        )),
                    Text(
                      S.of(context).labelUsersNearby,
                      textAlign: TextAlign.center,
                      style: TextStyles.text24.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocConsumer<FindNearbyBloc, FindNearbyState>(
                    listener: (context, state) {
                      if (state is SuccessfullyAddedContact) {
                        // Navigator.of(context).pushReplacementNamed(Routes.chat,
                        //     arguments: ChatArgs(contact: state.contact));
                      }
                    },
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: Durations.medium4,
                        child: switch (state) {
                          (final FindNearbyState state)
                              when state.devices.isEmpty =>
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                S.of(context).labelCantFindAnyUsersNearby,
                                textAlign: TextAlign.center,
                                style: TextStyles.text18Bold
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          (final FindNearbyState state)
                              when state.devices.isNotEmpty =>
                            ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) => DeviceItem(
                                      showAvailability: false,
                                      onTap: () {
                                        DialogUtil.showDefaultDialog(
                                          context,
                                          onYes: () {
                                            context.read<FindNearbyBloc>().add(
                                                AddContact(
                                                    contact:
                                                        state.devices[index]));
                                          },
                                          title: S
                                              .of(context)
                                              .labelAddThisUserToContactList,
                                        );
                                      },
                                      device: state.devices[index],
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 4.h,
                                    ),
                                itemCount: state.devices.length),
                          _ => const SizedBox(),
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
