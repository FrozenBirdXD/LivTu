import 'package:flutter/material.dart';
import 'package:livtu/services/auth/auth_exceptions.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  bool _passwordVisible = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when the user taps outside of the TextFields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.changePassword),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
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
                      AppLocalizations.of(context)!.enterNewPasswordPrompt,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    TextFormField(
                      validator: (password) => password != null &&
                              password.isEmpty
                          ? AppLocalizations.of(context)!.passwordCannotBeEmpty
                          : null,
                      controller: _controller,
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[250],
                        labelText: AppLocalizations.of(context)!.newPassword,
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
                      onFieldSubmitted: (value) async {
                        // hide keyboard when user taps register or presses enter
                        FocusScope.of(context).unfocus();
                        updatePassword();
                      },
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    // update password button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          // hide keyboard when user taps register or presses enter
                          FocusScope.of(context).unfocus();
                          updatePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.updatePassword,
                          style: const TextStyle(color: Colors.white),
                        ),
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

  void updatePassword() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        await AuthService.firebase()
            .changePassword(newPassword: _controller.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.passwordUpdateSuccessful),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      } on WeakPasswordAuthException {
        await showErrorDialog(
          context,
          AppLocalizations.of(context)!.weakPasswordAuthExceptionPrompt,
        );
      } on RequiresRecentLoginAuthException {
        await showErrorDialog(
          context,
          AppLocalizations.of(context)!.requiresRecentLoginAuthExceptionPrompt,
        );
      } catch (e) {
        await showErrorDialog(
          context,
          AppLocalizations.of(context)!.couldNotUpdatePasswordExceptionPrompt,
        );
      }
    }
  }
}
