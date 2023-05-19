import 'package:flutter/material.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';

class ChangeUsernameView extends StatefulWidget {
  const ChangeUsernameView({super.key});

  @override
  State<ChangeUsernameView> createState() => _ChangeUsernameViewState();
}

class _ChangeUsernameViewState extends State<ChangeUsernameView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Username'),
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
                      'Enter a new Username to update your current one.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    TextFormField(
                      validator: (name) => name != null && name.isEmpty
                          ? 'Username cannot be empty'
                          : null,
                      controller: _controller,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[250],
                        labelText: 'New Username',
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
                        updateName();
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
                          updateName();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Update Username',
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

  void updateName() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        AuthService.firebase().setDisplayName(newName: _controller.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username updated succesfully!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        await showErrorDialog(
          context,
          'Could not update username, please try again',
        );
      }
    }
  }
}
