// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/global/app.module.dart' as _i1037;
import '../../modules/global/bloc/global_bloc.dart' as _i182;
import '../provider/get_token_interceptor.dart' as _i321;
import 'firebase_auth.dart' as _i488;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i59.FirebaseAuth>(() => appModule.auth);
    gh.factory<_i182.GlobalBloc>(() => _i182.GlobalBloc());
    gh.lazySingleton<_i361.Dio>(() => appModule.dio());
    gh.factory<_i488.FirebaseAuthService>(
        () => _i488.FirebaseAuthService(gh<_i59.FirebaseAuth>()));
    gh.factory<_i321.GetTokenInterceptor>(
        () => _i321.GetTokenInterceptor(gh<_i488.FirebaseAuthService>()));
    return this;
  }
}

class _$AppModule extends _i1037.AppModule {}
