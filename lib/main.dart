import 'package:d_rank/core/config/injection.dart';
import 'package:d_rank/shared/extensions/build_context_extension.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:d_rank/routes/router.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await serviceLocator();
  Loggy.initLoggy();

  runApp(
    const ProviderScope(child: DRankApp()),
  );
}

class DRankApp extends StatelessWidget {
  const DRankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('en', 'US'),
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.black,
      borderRadius: BorderRadius.circular(10),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.slideFromLeft,
      reverseAnimation: StyledToastAnimation.slideToRightFade,
      curve: Curves.easeIn,
      reverseCurve: Curves.linear,
      duration: const Duration(seconds: 2),
      dismissOtherOnShow: true,
      animDuration: Duration.zero,
      fullWidth: true,
      isHideKeyboard: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'D-Rank',
        theme: AppTheme.themeData,
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('de', ''),
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
      ),
    );
  }
}
