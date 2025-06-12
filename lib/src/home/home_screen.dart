import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:kaonic/src/home/bloc/home_bloc.dart';
import 'package:kaonic/src/home/widgets/contact_item.dart';
import 'package:kaonic/src/widgets/circle_button.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/theme/assets.dart';
import 'package:kaonic/theme/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        callService: context.read<CallService>(),
        userService: context.read<UserService>(),
        kaonicCommunicationService: context.read(),
      ),
      child: PopScope(
        canPop: false,
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
                  Row(
                    children: [
                      Image.asset(
                        Assets.imageLogo,
                        width: 44.w,
                        height: 44.w,
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Align(
                              child: Text(
                                S.of(context).labelContactList,
                                textAlign: TextAlign.center,
                                style: TextStyles.text24
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                      ),
                      CircleButton(
                          icon: Assets.iconAdd,
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.findNearby);
                          }),
                      SizedBox(width: 10.w),
                      CircleButton(icon: Assets.iconSettings, onTap: () {})
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state is IncomingCall) {
                          Navigator.of(context).pushNamed(
                            Routes.call,
                            arguments: CallScreenState.incoming,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: Durations.medium4,
                          child: switch (state) {
                            (final HomeState state) when state.user == null =>
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "Unknown error",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.text18Bold
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            (final HomeState state)
                                when state.user != null &&
                                    state.user!.contacts.isEmpty =>
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "You don't have any contacts",
                                  textAlign: TextAlign.center,
                                  style: TextStyles.text18Bold
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            (final HomeState state)
                                when state.user != null &&
                                    state.user!.contacts.isNotEmpty =>
                              ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) => ContactItem(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.chat,
                                          arguments: state
                                              .user!.contacts[index].address,
                                        );
                                      },
                                      onIdentifyTap: () {},
                                      contact: state.user!.contacts[index],
                                      nearbyFound: state.nodes.contains(
                                          state.user!.contacts[index].address),
                                      unreadCount: state.unreadMessages[
                                          state.user!.contacts[index].address]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                  itemCount: state.user!.contacts.length),
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
      ),
    );
  }
}
