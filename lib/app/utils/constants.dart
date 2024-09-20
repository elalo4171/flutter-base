import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {}

class ApiEndpoints {
  static String baseUrl = dotenv.env['API_URL']!;
  static String product = '$baseUrl/api/v1/product';
}

class FirebaseConfig {
  static String apiKey = dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String authDomain = dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String project = dotenv.env['FIREBASE_PROJECT'] ?? '';
  static String storageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String messagingSenderId =
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String appId = dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String measurementId = dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';
}
