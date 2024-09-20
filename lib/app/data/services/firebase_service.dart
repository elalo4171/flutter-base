import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_app/app/data/services/get_it_services.dart';
import 'package:my_app/firebase_options.dart';

class FirebaseService {
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseService();
  }
}

class Services {
  static Future<void> initialize() async {
    configureDependencies();
    await FirebaseService.init();
    await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
    await initializeDateFormatting();
  }
}
