import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/theme/assets.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _enabled = true;

  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;

    if (!status.isGranted) {
      // Request permission
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      // Microphone permission granted, proceed with audio recording
      print("Microphone permission granted!");
    } else if (status.isDenied) {
      // Permission was denied
      print("Microphone permission denied.");
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, open app settings
      print(
          "Microphone permission is permanently denied, please open settings.");
      openAppSettings();
    }
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    Future.delayed(const Duration(milliseconds: 3550), () {
      if (context.read<UserService>().checkUserSignedIn() != null) {
        context.read<KaonicCommunicationService>().startService();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (_) => false);
      }
      setState(() {
        _enabled = true;
      });
    });

    requestMicrophonePermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.welcomeBg,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.2),
              child: Image.asset(
                Assets.imageWelcomeLogo,
                width: 200,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  label: S.of(context).login,
                  onPressed: !_enabled
                      ? null
                      : () => Navigator.of(context).pushNamed(Routes.login),
                ),
                const SizedBox(
                  height: 20,
                ),
                MainButton(
                  label: S.of(context).signUp,
                  onPressed: !_enabled
                      ? null
                      : () => Navigator.of(context).pushNamed(Routes.signUp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
