# Documento de Arquitectura del Proyecto

## 1. **Introducción**

Este proyecto fue creado utilizando los siguientes comandos para su configuración inicial:

1. **Crear la aplicación Flutter con el CLI de Very Good Ventures**:
   ```bash
   very_good create flutter_app my_app --desc "Custom Delivery App" --org "com.custom.org" --application-id "com.custom.app.user"
   ```

2. **Agregar las dependencias necesarias para el desarrollo**:
   ```bash
   flutter pub add bloc dio equatable firebase_auth firebase_core flutter_bloc flutter_svg flutter_dotenv font_awesome_flutter formz get_it go_router google_fonts injectable intl json_serializable path_provider rxdart
   ```

3. **Agregar dependencias de desarrollo**:
   ```bash
   flutter pub add --dev build_runner flutter_lints injectable_generator
   ```

Con estos comandos, establecí el entorno de desarrollo inicial de la aplicación, incluyendo herramientas de gestión de estado, comunicación HTTP, autenticación con Firebase, y generación automática de código.

---

## 2. **Estructura General**

El proyecto está organizado de manera modular dentro de la carpeta **lib/**. A continuación, se detalla la estructura del proyecto:

```
|-- lib
    |-- main_development.dart
    |-- main_production.dart
    |-- main_staging.dart
    |-- bootstrap.dart
    |-- app
        |-- modules
            |-- dashboard
                |-- dashboard_page.dart
                |-- dashboard_controller.dart
                |-- dashboard_web.dart
                |-- bloc
                    |-- dashboard_bloc.dart
                    |-- dashboard_event.dart
                    |-- dashboard_state.dart
            |-- global
                |-- bloc
                    |-- global_bloc.dart
                    |-- global_event.dart
                    |-- global_state.dart
                |-- app.module.dart
            |-- login
                |-- login_page.dart
                |-- login_controller.dart
                |-- login_web.dart
                |-- bloc
                    |-- login_bloc.dart
                    |-- login_event.dart
                    |-- login_state.dart
        |-- data
            |-- models
                |-- user_model.dart
                |-- product_model.dart
            |-- services
                |-- firebase_auth.dart
                |-- firebase_service.dart
                |-- get_it_services.config.dart
                |-- get_it_services.dart
            |-- provider
                |-- get_token_interceptor.dart
        |-- utils
            |-- colors_app.dart
            |-- constants.dart
            |-- enums.dart
            |-- theme.dart
        |-- routes
            |-- routes.dart
    |-- flavor
        |-- F.dart
        |-- Flavor.dart
```

---

## 3. **Inicialización de Dependencias**

### **App.module.dart**

Este archivo configura las dependencias que serán necesarias en el proyecto. Aquí, por ejemplo, se utiliza `FirebaseAuth` y la biblioteca `Dio` para manejar peticiones HTTP. También se configura el interceptor para gestionar tokens de autenticación.

```dart
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
```

Este módulo se asegura de que Firebase y Dio estén correctamente inicializados y configurados con las opciones adecuadas, como los tiempos de espera y los encabezados predeterminados.

---

## 4. **Gestión de Rutas y Autenticación**

### **routes.dart**

El archivo `routes.dart` define las rutas de la aplicación, y utiliza `GoRouter` para la navegación. También gestiona las redirecciones basadas en el estado de la sesión del usuario mediante el `GlobalBloc`.

```dart
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
```

Este ejemplo muestra cómo se gestionan las rutas y las redirecciones en función del estado de autenticación del usuario.

---

## 5. **Estructura del Componente Principal de la App**

### **App.dart**

El archivo `App.dart` es el componente raíz de la aplicación. Usa `MultiBlocProvider` para inyectar el `GlobalBloc` y configurar la interfaz gráfica con `MaterialApp.router` y las rutas de navegación.

```dart
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
```

Aquí se observa cómo se monitorea el estado de autenticación de Firebase, y cómo se actualiza el `GlobalBloc` en función de si el usuario está autenticado o no.

---

## 6. **Bootstrap de la Aplicación**

### **bootstrap.dart**

Este archivo maneja la inicialización global de la aplicación, configurando el entorno, los observadores de BLoC y las dependencias necesarias, como Firebase.

```dart
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/app/data/services/firebase_service.dart';
import 'package:my_app/flavors.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  Flavor flavor,
) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  F.appFlavor = flavor;
  await dotenv.load(fileName: F.envFilePath);
  await Services.initialize();
  runApp(await builder());
}
```

Este archivo asegura que la aplicación está correctamente configurada según el entorno, carga los archivos `.env` adecuados y asegura que Firebase está inicializado.

---

## 7. **Servicios de Firebase**

### **Firebase_services.dart**

Este archivo se encarga de la configuración e inicialización de Firebase y otros servicios necesarios, como la persistencia de sesiones y la localización.

```dart
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
```

Este archivo maneja la inicialización de Firebase y la configuración de la persistencia de sesión, asegurando que el usuario no tenga que autenticarse nuevamente mientras la sesión esté activa.

---

## 8. **Comandos Más Usados**

A lo largo del ciclo de desarrollo, hay varios comandos que utilizo frecuentemente para generar código, gestionar dependencias y configurar el entorno.

1. **Generar código con `injectable`**:
   ```bash
   flutter pub run build_runner build
   ```

2. **Ver cambios automáticos en la generación de código**:
   ```bash
   flutter pub run build_runner watch
   ```

3. **Iniciar la aplicación en un ambiente específico**:
   - Desarrollo:
     ```bash
     flutter run --flavor development -t lib/main_development.dart
     ```
   - Producción:
     ```bash
     flutter run --flavor production -t lib/main_production.dart
     ```
   - QA:
     ```bash
     flutter run --flavor qa -t lib/main_staging.dart
     ```

4. **Agregar dependencias**:
   ```bash
   flutter pub get
   ```

Estos comandos me permiten automatizar tareas comunes y asegurar que el entorno de desarrollo esté correctamente configurado.

---

## 9. **Conclusión y Próximos Pasos**

Este documento ofrece una guía completa sobre la arquitectura modular de mi proyecto en Flutter, combinando explicaciones detalladas con ejemplos de código y los comandos más utilizados para desarrollar y mantener el proyecto.

Además de este documento, estoy considerando crear un video explicativo sobre la arquitectura para proporcionar una mejor comprensión visual y práctica. Esto no solo me ayudará a organizar mis ideas, sino que también servirá como un recurso útil para futuros colaboradores que se sumen al proyecto.
