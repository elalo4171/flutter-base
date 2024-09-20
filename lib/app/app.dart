import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/app/data/services/get_it_services.dart';
import 'package:my_app/app/modules/global/bloc/global_bloc.dart';
import 'package:my_app/app/routes/routes.dart';
import 'package:my_app/app/utils/theme.dart';
import 'package:my_app/flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GlobalBloc>(),
        ),
      ],
      child: _App(key: key),
    );
  }
}

class _App extends StatefulWidget {
  const _App({super.key});

  @override
  State<_App> createState() => __AppState();
}

class __AppState extends State<_App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: F.title,
      theme: buildThemeData(),
      routerConfig: router,
      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final firebaseAuth = getIt<FirebaseAuth>();
          final globalBloc = context.read<GlobalBloc>();
          if (globalBloc.state.hasSession) {
            return;
          } else {
            firebaseAuth.authStateChanges().listen((User? user) async {
              if (!mounted) return;
              if (user == null) {
                context.read<GlobalBloc>().add(
                      const AppStarted(
                        hasSession: false,
                        jwtToken: '',
                      ),
                    );
              } else {
                final jwtToken = await user.getIdToken();
                context.read<GlobalBloc>().add(
                      AppStarted(
                        hasSession: true,
                        jwtToken: jwtToken,
                      ),
                    );
              }
            });
          }
        });
        return child!;
      },
    );
  }
}
