import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/app/data/services/firebase_auth.dart';

@injectable
class GetTokenInterceptor implements InterceptorsWrapper {
  GetTokenInterceptor(this.firebaseAuthService);
  final FirebaseAuthService firebaseAuthService;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('GetTokenInterceptor: ${options.uri}');
    log('GetTokenInterceptor: ${options.headers}');
    final token = await firebaseAuthService.getToken();
    log('GetTokenInterceptor: $token');
    if (token != null && token.isNotEmpty) {
      options.headers['x-access-token'] = token;
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
