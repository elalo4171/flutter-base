import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/app/data/provider/get_token_interceptor.dart';
import 'package:my_app/app/data/services/get_it_services.dart';
import 'package:my_app/app/utils/constants.dart';

@module
abstract class AppModule {
  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      )..interceptors.add(getIt<GetTokenInterceptor>());
}
