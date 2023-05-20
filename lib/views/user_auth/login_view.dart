import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/services/auth/auth_exceptions.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordVisible = false;
  // for when user presses enter
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bloc listener for auth exceptions
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoggedOutState) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              AppLocalizations.of(context)!.userNotFoundAuthExceptionPrompt,
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              AppLocalizations.of(context)!.wrongPasswordAuthExceptionPrompt,
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              AppLocalizations.of(context)!.invalidEmailAuthExceptionPrompt,
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              AppLocalizations.of(context)!.authenticationError,
            );
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          // Hide the keyboard when the user taps outside of the TextFields
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36.0,
                  vertical: 48.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcomeBack,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.logInToLivTuPrompt,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      // email text field
                      TextFormField(
                        controller: _email,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          labelStyle: const TextStyle(fontSize: 16.0),
                          filled: true,
                          fillColor: Colors.grey[250],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          _submitFormLogin();
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // password text field
                      TextFormField(
                        controller: _password,
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          labelStyle: const TextStyle(fontSize: 16.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[250],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          _submitFormLogin();
                        },
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      // login button
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            _submitFormLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            textStyle: const TextStyle(fontSize: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.logIn,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // Forgot password
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(const AuthForgotPasswordEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).secondaryHeaderColor,
                            textStyle: const TextStyle(fontSize: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(AppLocalizations.of(context)!.forgotPassword),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // Go to register view button
                      SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(const AuthShouldRegisterEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).secondaryHeaderColor,
                            textStyle: const TextStyle(fontSize: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child:
                              Text(AppLocalizations.of(context)!.notRegisteredGoToSignUp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitFormLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // hide keyboard when user taps login or presses enter
      FocusScope.of(context).unfocus();
      // simulate tap on login button
      BlocProvider.of<AuthBloc>(context).add(
        AuthLoginEvent(
          _email.text,
          _password.text,
          context,
        ),
      );
    }
  }
}
