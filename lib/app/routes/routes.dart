import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/app/modules/dashboard/dashboard_page.dart';
import 'package:my_app/app/modules/global/bloc/global_bloc.dart';
import 'package:my_app/app/modules/login/login_page.dart';

final router = GoRouter(
  initialLocation: LoginPage.path,
  routes: [
    GoRoute(
      path: LoginPage.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: DashboardPage.path,
      builder: (context, state) => const DashboardPage(),
    ),
  ],
  redirect: (context, state) {
    final currentUser = context.read<GlobalBloc>().state;
    if (currentUser.hasSession == false) {
      return LoginPage.path; // Redirige al login si no hay usuario
    }
    return null;
  },
);
