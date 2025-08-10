import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { dev, staging, prod }

class Environment {
  final AppEnvironment name;
  final String apiBaseUrl;
  final bool enableNetworkLogs;

  const Environment({
    required this.name,
    required this.apiBaseUrl,
    required this.enableNetworkLogs,
  });

  static late Environment current;

  static Future<void> load(String env) async {
    switch (env) {
      case 'staging':
        await dotenv.load(fileName: 'env/.env.staging');
        current = Environment(
          name: AppEnvironment.staging,
          apiBaseUrl: dotenv.get('API_BASE_URL', fallback: 'https://staging.api.nwaslouk.tn'),
          enableNetworkLogs: dotenv.get('ENABLE_NETWORK_LOGS', fallback: 'true') == 'true',
        );
        break;
      case 'prod':
        await dotenv.load(fileName: 'env/.env.production');
        current = Environment(
          name: AppEnvironment.prod,
          apiBaseUrl: dotenv.get('API_BASE_URL', fallback: 'https://api.nwaslouk.tn'),
          enableNetworkLogs: dotenv.get('ENABLE_NETWORK_LOGS', fallback: 'false') == 'true',
        );
        break;
      case 'dev':
      default:
        await dotenv.load(fileName: 'env/.env.development');
        current = Environment(
          name: AppEnvironment.dev,
          apiBaseUrl: dotenv.get('API_BASE_URL', fallback: 'http://10.0.2.2:3000'),
          enableNetworkLogs: dotenv.get('ENABLE_NETWORK_LOGS', fallback: 'true') == 'true',
        );
        break;
    }
  }
}