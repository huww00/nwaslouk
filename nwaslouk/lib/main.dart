import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/service_locator.dart';
import 'core/env/environment.dart';
import 'core/logging/app_logger.dart';
import 'presentation/app/nwaslouk_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine environment via --dart-define=ENV=dev|staging|prod
  final String env = const String.fromEnvironment('ENV', defaultValue: 'dev');
  await Environment.load(env);

  await configureDependencies();

  AppLogger.i('Starting Nwaslouk in ${Environment.current.name} environment');

  runApp(const ProviderScope(child: NwasloukApp()));
}