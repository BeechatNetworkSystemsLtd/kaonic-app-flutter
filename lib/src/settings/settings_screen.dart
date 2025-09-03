import 'package:flutter/material.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _appVersion;

  @override
  void initState() {
    super.initState();
    _getBuildInfo();
  }

  void _getBuildInfo() async {
    final info = await PackageInfo.fromPlatform();
    _appVersion = 'App version: ${info.version}+${info.buildNumber}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final settings = <Widget>[
      _SettingsItem(
        title: S.of(context).softwareUpdate,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.ota);
        },
      ),
      _SettingsItem(
        title: S.of(context).radioSettings,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.radioSettings);
        },
      ),
      _SettingsItem(
        title: S.of(context).connectivitySettings,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.connectivitySettings);
        },
      ),
    ];

    return Scaffold(
      appBar: CustomAppbar(title: S.of(context).settings),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return settings.elementAt(index);
                },
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.white38,
                ),
                itemCount: settings.length,
              ),
              if (_appVersion != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    _appVersion!,
                    textAlign: TextAlign.center,
                    style: TextStyles.text14.copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.text18Bold.copyWith(color: Colors.white),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
