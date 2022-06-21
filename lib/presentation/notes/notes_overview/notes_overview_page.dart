import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ddd_firebase/application/auth/auth_bloc.dart';
import 'package:ddd_firebase/application/notes/note_actor/note_actor_bloc.dart';
import 'package:ddd_firebase/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:ddd_firebase/injection.dart';
import 'package:ddd_firebase/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:ddd_firebase/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:ddd_firebase/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
            create: (context) => getIt<NoteWatcherBloc>()
              ..add(const NoteWatcherEvent.watchAllStarted())),
        BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            state.maybeMap(
                unAuthenticated: (_) =>
                    AutoRouter.of(context).replace(const SignInRoute()),
                orElse: () {});
          }),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                      duration: const Duration(seconds: 5),
                      message: state.failure.map(
                          unexpected: (_) =>
                              'Unexpected error occurred while deleting please contact support',
                          insufficientPermission: (_) =>
                              'Insufficient permissions',
                          unableToUpdate: (_) =>
                              'Impossible error')).show(context);
                },
                orElse: () {});
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(const AuthEvent.signedOut());
              },
            ),
            actions:const <Widget>[
              UncompletedSwitch()
            ],
          ),
          body: const NoteOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(NoteFormRoute(editNote: null));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
