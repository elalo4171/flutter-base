import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/app/data/services/get_it_services.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true,
)
void configureDependencies() => getIt.init();
