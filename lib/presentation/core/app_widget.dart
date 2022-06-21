import 'package:ddd_firebase/application/auth/auth_bloc.dart';
import 'package:ddd_firebase/injection.dart';
import 'package:ddd_firebase/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppWidget extends StatelessWidget {

  final appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested())),
      ],
      child: MaterialApp.router(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue[900]
          ),
          primaryColorDark: Colors.green[800],
          primaryColorLight: Colors.green[800],
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          ),
      ),
    routerDelegate: appRouter.delegate(),
    routeInformationParser: appRouter.defaultRouteParser(),),);
  }
}