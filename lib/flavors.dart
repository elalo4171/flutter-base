// ignore_for_file: constant_identifier_names

enum Flavor {
  DEV,
  PROD,
  QA,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Holter Dev';
      case Flavor.PROD:
        return 'Holter Delivery';
      case Flavor.QA:
        return 'Holter QA';
      case null:
        return 'Holter';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'http://localhost:3000';
      case Flavor.PROD:
        return 'https://managment.com';
      case Flavor.QA:
        return 'https://qa.managment.com';
      case null:
        return 'https://managment.com';
    }
  }

  static String get envFilePath {
    switch (appFlavor) {
      case Flavor.DEV:
        return '.env.dev';
      case Flavor.PROD:
        return '.env';
      case Flavor.QA:
        return '.env.dev';
      case null:
        return '.env';
    }
  }
}
