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
      light: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      dark: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
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
          routeInformationProvider:
              ref.read(goRouterProvider).routeInformationProvider,
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, child!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.resize(600, name: TABLET),
              ResponsiveBreakpoint.resize(800, name: DESKTOP),
              ResponsiveBreakpoint.resize(1700, name: 'XL'),
            ],
            background: Container(color: Theme.of(context).colorScheme.surface),
          ),
        );
      },
    );
  }
}
