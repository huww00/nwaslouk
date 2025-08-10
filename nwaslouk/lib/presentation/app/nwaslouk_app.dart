import 'package:flutter/material.dart';
import '../../core/routing/app_router.dart';
import 'theme/app_theme.dart';

class NwasloukApp extends StatelessWidget {
  const NwasloukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nwaslouk',
      debugShowCheckedModeBanner: false,
      theme: nwasloukTheme,
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes,
    );
  }
}