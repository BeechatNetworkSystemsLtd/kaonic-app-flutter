import 'package:kaonic/data/models/user_model.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/chat_service.dart';
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
import 'package:kaonic/utils/dialog_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatService>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        chatService: context.read(),
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
                      BlocSelector<HomeBloc, HomeState, UserModel?>(
                        selector: (state) => state.user,
                        builder: (context, user) {
                          return CircleButton(
                            icon: Assets.iconAdd,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Routes.findNearby,
                                arguments: user?.contactAddressList ?? [],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      CircleButton(
                          icon: Assets.iconSettings,
                          onTap: () =>
                              Navigator.of(context).pushNamed(Routes.settings))
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state is IncomingCall) {
                          if (!state.isInChatPage) {
                            Navigator.of(context).pushNamed(
                              Routes.chat,
                              arguments: state.address ?? '',
                            );
                          }
                          Navigator.of(context).pushNamed(
                            Routes.call,
                            arguments: CallScreenStateInfo(
                                callScreenState: CallScreenState.incoming),
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
                                  itemBuilder: (context, index) {
                                    final contact =
                                        state.user!.contacts.elementAt(index);
                                    return ContactItem(
                                      lastMessage:
                                          state.lastMessages[contact.address],
                                      onTap: () async {
                                        context
                                            .read<HomeBloc>()
                                            .add(OnChatNavigate(true));

                                        await Navigator.of(context)
                                            .pushNamed(
                                          Routes.chat,
                                          arguments: contact.address,
                                        )
                                            .whenComplete(() {
                                          if (context.mounted) {
                                            context
                                                .read<HomeBloc>()
                                                .add(OnChatNavigate(false));
                                          }
                                        });
                                      },
                                      onIdentifyTap: () {},
                                      contact: contact,
                                      nearbyFound:
                                          state.nodes.contains(contact.address),
                                      unreadCount:
                                          state.unreadMessages[contact.address],
                                      onLongPress: () {
                                        DialogUtil.showDefaultDialog(
                                          context,
                                          onYes: () {
                                            context.read<HomeBloc>().add(
                                                  RemoveContact(
                                                    contact: contact.address,
                                                  ),
                                                );
                                          },
                                          title: S
                                              .of(context)
                                              .labelRemoveThisUserFromContactList,
                                        );
                                      },
                                    );
                                  },
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
