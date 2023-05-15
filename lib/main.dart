import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/services/auth/firebase_auth_provider.dart';
import 'package:livtu/utils/loading/loading_screen.dart';
import 'package:livtu/views/overview/overview.dart';
import 'package:livtu/views/schedule/schedule_view.dart';
import 'package:livtu/views/study_material/study_material_view.dart';
import 'package:livtu/views/tutor/tutor_view.dart';
import 'package:livtu/views/user_auth/forgot_password_view.dart';
import 'package:livtu/views/user_auth/login_view.dart';
import 'package:livtu/views/profile/change_password_view.dart';
import 'package:livtu/views/profile/profile_view.dart';
import 'package:livtu/views/user_auth/register_view.dart';
import 'package:livtu/views/user_auth/verify_email_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    const MyApp(
      locale: Locale('en'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({required this.locale, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
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
    ProfileView(),
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
            text: state.loadingText ?? "In a moment, we'll be ready.",
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
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_center_outlined),
                  label: 'Overview',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Tutor',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: 'Study Material',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
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
        } else if (state is AuthChangePasswordState) {
          return const ChangePasswordView();
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
