import 'package:flutter/material.dart';
import 'package:livtu/services/auth/auth_exceptions.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';

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
          title: const Text('Change Password'),
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
                    const Text(
                      'Enter a new password to update your current one.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    TextFormField(
                      validator: (password) =>
                          password != null && password.isEmpty
                              ? 'Password cannot be empty'
                              : null,
                      controller: _controller,
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[250],
                        labelText: 'New Password',
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
                        child: const Text(
                          'Update Password',
                          style: TextStyle(color: Colors.white),
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
          const SnackBar(
            content: Text('Password updated succesfully!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      } on WeakPasswordAuthException {
        await showErrorDialog(
          context,
          'Weak password - Please enter a stronger password.',
        );
      } on RequiresRecentLoginAuthException {
        await showErrorDialog(
          context,
          'This operation requires you to have logged in recently. Please log in and try again.',
        );
      } catch (e) {
        await showErrorDialog(
          context,
          'Could not update password, please try again',
        );
      }
    }
  }
}
