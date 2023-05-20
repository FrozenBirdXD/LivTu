// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/services/auth/auth_exceptions.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';
import 'package:livtu/utils/dialogs/reset_password_email_sent_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthForgotPasswordState) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showResetPasswordEmailSentDialog(context);
          }
          if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
                context, AppLocalizations.of(context)!.invalidEmailAuthExceptionPrompt);
          } else if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context,
                AppLocalizations.of(context)!.userNotFoundAuthExceptionPrompt);
          } else if (state.exception != null) {
            await showErrorDialog(context,
                AppLocalizations.of(context)!.notProcessedTryAgainPrompt);
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          // Hide the keyboard when the user taps outside of the TextField
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.forgotPasswordDontWorry,
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
                      AppLocalizations.of(context)!.forgotPasswordInstructions,
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
                      controller: _controller,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[250],
                        labelText: AppLocalizations.of(context)!.email,
                        labelStyle: const TextStyle(fontSize: 16.0),
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
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    // send email button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          final email = _controller.text;

                          FocusScope.of(context).unfocus(); // hide keyboard
                          // send mail
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthForgotPasswordEvent(email: email),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.sendPasswordResetLink,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    // Go to login view button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(const AuthLogoutEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).secondaryHeaderColor,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.goBackToLogin),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
