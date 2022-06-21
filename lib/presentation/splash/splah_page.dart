import 'package:auto_route/auto_route.dart';
import 'package:ddd_firebase/application/auth/auth_bloc.dart';
import 'package:ddd_firebase/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {
          },
          authenticated: (_) {
            AutoRouter.of(context).replace(const NotesOverviewRoute());
          },
          unAuthenticated: (_) {
            AutoRouter.of(context).replace(const SignInRoute());
          },
        );
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
