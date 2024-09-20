import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/data/services/firebase_auth.dart';
import 'package:my_app/app/data/services/get_it_services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Login Page'),
          ),
          ElevatedButton(
            onPressed: () async {
              await getIt<FirebaseAuthService>()
                  .signInWithEmailAndPassword('', '');
              if (kDebugMode) {
                print(await getIt<FirebaseAuthService>().getToken());
              }
            },
            child: const Text('Login'),
          ),
          //Button to print token
          ElevatedButton(
            onPressed: () async {
              if (kDebugMode) {
                print(await getIt<FirebaseAuthService>().getToken());
              }
            },
            child: const Text('Print Token'),
          ),
        ],
      ),
    );
  }
}
