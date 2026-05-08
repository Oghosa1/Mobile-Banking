import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

enum Env { dev, staging, prod }

class AppConfig {
  final Env type;
  final String baseUrl;
  final String appName;
  final bool enableMock;

  const AppConfig({
    required this.type,
    required this.baseUrl,
    required this.appName,
    required this.enableMock,
  });

  /// Instantiates AppConfig from Dart's compile-time environment variables.
  factory AppConfig.fromEnvironment() {
    const envString = String.fromEnvironment('ENV', defaultValue: 'dev');
    final type = Env.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => Env.dev,
    );

    return AppConfig(
      type: type,
      baseUrl: type == Env.prod
          ? 'https://api.fintechapp.io/v1'
          : type == Env.staging
              ? 'https://api-staging.fintechapp.io/v1'
              : 'https://api-dev.fintechapp.io/v1',
      appName: type == Env.prod
          ? 'FinTech'
          : type == Env.staging
              ? 'FinTech Staging'
              : 'FinTech Dev',
      enableMock: type != Env.prod,
    );
  }

  bool get isProd => type == Env.prod;
  bool get isDebugMode => type != Env.prod;
}

/// Provider for the compile-time safe AppConfig.
final environmentProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

/// Provider for a pre-configured Dio instance based on the active environment.
final dioProvider = Provider<Dio>((ref) {
  final env = ref.watch(environmentProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: env.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );

  if (env.isDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  return dio;
});
