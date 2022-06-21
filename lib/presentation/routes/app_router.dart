import 'package:auto_route/annotations.dart';
import 'package:ddd_firebase/presentation/notes/note_form/note_form_page.dart';
import 'package:ddd_firebase/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:ddd_firebase/presentation/sign_in/sign_in_page.dart';
import 'package:ddd_firebase/presentation/splash/splah_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: NotesOverviewPage),
    AutoRoute(page: NoteFormPage),
  ],
)
class $AppRouter {}