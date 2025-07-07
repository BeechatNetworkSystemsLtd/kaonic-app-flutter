import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/src/login/bloc/login_bloc.dart';
import 'package:kaonic/src/widgets/back_button.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/utils/snackbar_util.dart';

import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginBloc _bloc;
  final usernameController = TextEditingController();

  @override
  void initState() {
    _bloc = LoginBloc(
      context.read(),
      context.read(),
      userService: context.read(),
    );
    super.initState();
  }

  void _listenStates(BuildContext context, state) {
    if (state is LoginFailure) {
      SnackBarUtil.showError(context, error: S.of(context).loginFailure);
      return;
    }
    if (state is LoginSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContainer(
          child: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: _listenStates,
          child: Flex(
            direction: Axis.vertical,
            children: [
              SizedBox(
                height: 24.h + MediaQuery.of(context).padding.top,
              ),
              AppBackButton(label: S.of(context).login),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${S.of(context).username}:',
                          style:
                              TextStyles.text20.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: MainTextField(
                              controller: usernameController,
                              onChange: (value) => _bloc
                                  .add(LoginInputsChanged(username: value)),
                            )),
                      ],
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) => MainButton(
                        label: S.of(context).login,
                        onPressed: (state is LoginInitial
                                ? state.btnEnabled
                                : false)
                            ? () =>
                                _checkPasscode(context, usernameController.text)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _checkPasscode(BuildContext context, String username) async {
    final passcode = await Navigator.of(context).pushNamed(Routes.passcode);
    if (passcode is String) {
      _bloc.add(LoginUser(username: username, passcode: passcode));
    }
  }
}
