import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/services/auth/firebase_auth_provider.dart';
import 'package:livtu/services/settings/language_provider.dart';
import 'package:livtu/utils/loading/loading_screen.dart';
import 'package:livtu/views/become_tutor/become_tutor_view.dart';
import 'package:livtu/views/overview/overview.dart';
import 'package:livtu/views/profile/change_username_view.dart';
import 'package:livtu/views/schedule/edit_event_view.dart';
import 'package:livtu/services/schedule/provider/event_provider.dart';
import 'package:livtu/views/schedule/schedule_view.dart';
import 'package:livtu/views/settings/settings_view.dart';
import 'package:livtu/views/study_material/study_material_view.dart';
import 'package:livtu/views/support/support_view.dart';
import 'package:livtu/views/tutor/tutor_view.dart';
import 'package:livtu/views/user_auth/forgot_password_view.dart';
import 'package:livtu/views/user_auth/login_view.dart';
import 'package:livtu/views/profile/change_password_view.dart';
import 'package:livtu/views/profile/profile_view.dart';
import 'package:livtu/views/user_auth/register_view.dart';
import 'package:livtu/views/user_auth/verify_email_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider(
            const Locale('en'),
          ),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          routes: {
            editCalendarEventRoute: (context) => const EditEventView(),
            settingsRoute: (context) => const SettingsView(),
            profileRoute: (context) => const ProfileView(),
            changePasswordRoute: (context) => const ChangePasswordView(),
            changeUsernameRoute: (context) => const ChangeUsernameView(),
            supportRoute: (context) => const SupportView(),
            becomeTutorRoute: (context) => const BecomeTutorView(),
          },
          title: 'LivTu',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme(
              primary: Colors.teal,
              onPrimary: Colors.white,
              secondary: Colors.lightBlue,
              onSecondary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              background: Colors.grey.shade100,
              error: Colors.red,
              onError: Colors.white,
              brightness: Brightness.light,
              onBackground: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.grey,
            ),
          ),
          home: BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(FirebaseAuthProvider()),
            child: const HomePage(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // index of navigator selection
  int _currentIndex = 0;
  // list of views for navigator
  final List<Widget> _views = [
    const Overview(),
    const ScheduleView(),
    const TutorView(),
    const StudyMaterialView(),
  ];

  @override
  Widget build(BuildContext context) {
    // initialize
    BlocProvider.of<AuthBloc>(context).add(const AuthInitEvent());
    // check state of builder all the time ---> also checks if state has isLoading true
    // if state change in e.g. login view, this is called
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ??
                AppLocalizations.of(context)!.inAMomentReadyPrompt,
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthLoggedInState) {
          // return correct view
          return Scaffold(
            body: _views[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.overview,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_month),
                  label: AppLocalizations.of(context)!.schedule,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.people),
                  label: AppLocalizations.of(context)!.tutor,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.menu_book_rounded),
                  label: AppLocalizations.of(context)!.studyMaterial,
                ),
              ],
            ),
          );
        } else if (state is AuthNeedVerificationState) {
          return const VerifyEmailView();
        } else if (state is AuthLoggedOutState) {
          return const LoginView();
        } else if (state is AuthRegisteringState) {
          return const RegisterView();
        } else if (state is AuthForgotPasswordState) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
