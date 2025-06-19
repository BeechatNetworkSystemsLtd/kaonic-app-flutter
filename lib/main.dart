import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/models/user_model.dart';
import 'package:kaonic/data/repository/storage.dart';
import 'package:kaonic/data/repository/user_repository.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/chat_service.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:kaonic/src/call/call_screen.dart';
import 'package:kaonic/src/chat/chat_screen.dart';
import 'package:kaonic/src/find_nearby/find_nearby_screen.dart';
import 'package:kaonic/src/home/home_screen.dart';
import 'package:kaonic/src/login/login_screen.dart';
import 'package:kaonic/src/passcode/passcode_screen.dart';
import 'package:kaonic/src/settings/settings_screen.dart';
import 'package:kaonic/src/sign_up/save_backup_screen.dart';
import 'package:kaonic/src/sign_up/sign_up_screen.dart';
import 'package:kaonic/src/welcome_screen.dart';
import 'package:kaonic/theme/theme.dart';

const mocked = true;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final designSize = const Size(375, 812);
  final _storageService = StorageService();
  final _kaonicCommunicationService = KaonicCommunicationService();
  late final _chatService = ChatService(_kaonicCommunicationService);
  late final _callService = CallService(_kaonicCommunicationService);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: designSize,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => _kaonicCommunicationService),
            RepositoryProvider(create: (context) => _chatService),
            RepositoryProvider(create: (context) => _callService),
            RepositoryProvider(create: (context) => _storageService),
            RepositoryProvider(
              create: (context) => UserService(
                userRepository: UserRepository(storageService: _storageService),
              ),
            ),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.initial,
              theme: appThemeData,
              localizationsDelegates: const [
                S.delegate,
              ],
              routes: {
                Routes.initial: (context) => const WelcomeScreen(),
                Routes.signUp: (context) => const SignUpScreen(),
                Routes.login: (context) => const LoginScreen(),
                Routes.passcode: (context) => PasscodeScreen(
                      username:
                          ModalRoute.of(context)?.settings.arguments as String?,
                    ),
                Routes.saveBackup: (context) => SaveBackupScreen(
                      user: ModalRoute.of(context)?.settings.arguments
                          as UserModel,
                    ),
                Routes.home: (context) => const HomeScreen(),
                Routes.findNearby: (context) => const FindNearbyScreen(),
                Routes.chat: (context) => ChatScreen(
                      address:
                          ModalRoute.of(context)?.settings.arguments as String,
                    ),
                Routes.call: (context) => CallScreen(
                      callState: ModalRoute.of(context)?.settings.arguments
                          as CallScreenState,
                    ),
                Routes.settings: (context) => const SettingsScreen(),
              }),
        ));
  }
}
