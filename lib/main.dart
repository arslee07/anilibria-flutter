import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:anilibria_app/utils/route_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveTheme(
      light: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.black,
          brightness: Brightness.light,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        chipTheme: Theme.of(context).chipTheme.copyWith(
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
      ),
      dark: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.white,
          brightness: Brightness.dark,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey,
        ),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          title: 'Anilibria',
          theme: theme,
          darkTheme: darkTheme,
          routeInformationParser:
              ref.read(goRouterProvider).routeInformationParser,
          routerDelegate: ref.read(goRouterProvider).routerDelegate,
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, child!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.resize(600, name: TABLET),
              ResponsiveBreakpoint.resize(800, name: DESKTOP),
              ResponsiveBreakpoint.resize(1700, name: 'XL'),
            ],
            background: Container(color: const Color(0xFFF5F5F5)),
          ),
        );
      },
    );
  }
}
