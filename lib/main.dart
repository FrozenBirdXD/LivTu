import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/services/auth/firebase_auth_provider.dart';
import 'package:livtu/utils/loading/loading_screen.dart';
import 'package:livtu/views/overview/overview.dart';
import 'package:livtu/views/profile/change_username_view.dart';
import 'package:livtu/views/schedule/edit_event_view.dart';
import 'package:livtu/views/schedule/provider/event_provider.dart';
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
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        routes: {
          editCalendarEventRoute: (context) => const EditEventView(),
          settingsRoute: (context) => ProfileView(),
          changePasswordRoute: (context) => const ChangePasswordView(),
          changeUsernameRoute: (context) => const ChangeUsernameView(),
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
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
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
