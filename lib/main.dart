import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/auth_service.dart';
import 'presentation/pages/disguise_screen.dart';
import 'presentation/pages/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppTheme.surfaceDark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Hive
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.hiveBoxSettings);
  await Hive.openBox(AppConstants.hiveBoxSecurity);

  final isSetup = await AuthService.isSetupComplete();

  runApp(GhostLockApp(isSetupComplete: isSetup));
}

class GhostLockApp extends StatefulWidget {
  final bool isSetupComplete;
  const GhostLockApp({super.key, required this.isSetupComplete});
  @override State<GhostLockApp> createState() => _GhostLockAppState();
}

class _GhostLockAppState extends State<GhostLockApp> {
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool(AppConstants.keyThemeMode) ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghost Lock AI',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme:     AppTheme.lightTheme,
      darkTheme:  AppTheme.darkTheme,
      home: widget.isSetupComplete
          ? const DisguiseScreen()
          : const OnboardingScreen(),
      // Prevent screenshot / screen recording metadata (Android)
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}
