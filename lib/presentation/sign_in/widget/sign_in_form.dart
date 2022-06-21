import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ddd_firebase/application/auth/auth_bloc.dart';
import 'package:ddd_firebase/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:ddd_firebase/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        listener: (context, state) {
      state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold((failure) {
                FlushbarHelper.createError(
                    message: failure.map(
                        cancelledByUser: (_) => 'Cancelled',
                        serverError: (_) => 'Server error',
                        emailAlreadyInUse: (_) => 'Email already in use',
                        invalidEmailAndPasswordCombination: (_) =>
                            'Invalid email and password combination'));
              }, (_) {
                AutoRouter.of(context).replace(const NotesOverviewRoute());
                BlocProvider.of<AuthBloc>(context).add(const AuthEvent.authCheckRequested());
              }));
    }, builder: (context, state) {
      return Form(
          autovalidateMode: state.showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                '📝',
                style: TextStyle(fontSize: 130),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email), labelText: 'Email'),
                  autocorrect: false,
                  onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                      .state
                      .emailAddress
                      .value
                      .fold(
                          (f) => f.maybeMap(
                              invalidEmail: (_) => 'Invalid Email',
                              orElse: () => null),
                          (r) => null)),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock), labelText: 'Password'),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .password
                    .value
                    .fold(
                        (f) => f.maybeMap(
                            shortPassword: (_) => 'Short Password',
                            orElse: () => null),
                        (r) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<SignInFormBloc>(context).add(
                              const SignInFormEvent
                                  .signInWithEmailAndPassword());
                        },
                        child: const Text('SIGN IN'))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<SignInFormBloc>(context).add(
                              const SignInFormEvent
                                  .registerWithEmailAndPassword());
                        },
                        child: const Text('REGISTER'))),
              ]),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SignInFormBloc>(context)
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 8,
                    onPrimary: Colors.white
                  ),
                  child: const Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              if (state.isSubmitting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(value: null)
              ]
            ],
          ));
    });
  }
}
