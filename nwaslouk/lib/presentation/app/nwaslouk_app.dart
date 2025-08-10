import 'package:flutter/material.dart';
import '../../core/routing/app_router.dart';

class NwasloukApp extends StatelessWidget {
  const NwasloukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nwaslouk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7490)),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes,
    );
  }
}