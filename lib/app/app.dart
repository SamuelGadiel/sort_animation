import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF454174));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        cardTheme: CardTheme(color: colorScheme.onInverseSurface),
        buttonTheme: ButtonThemeData(
          height: 36
        ),
      ),
      home: HomePage(),
    );
  }
}
