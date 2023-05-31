import 'package:flutter/material.dart';
import 'package:livtu/services/profile/global_user_service.dart';
import 'package:livtu/utils/dialogs/error_dialog.dart';

class ChangeDescriptionView extends StatefulWidget {
  const ChangeDescriptionView({super.key});

  @override
  State<ChangeDescriptionView> createState() => _ChangeDescriptionViewState();
}

class _ChangeDescriptionViewState extends State<ChangeDescriptionView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late Stream<String> _descriptionStream;

  @override
  void initState() {
    _controller = TextEditingController();
    _descriptionStream = GlobalUserService().getDescriptionStream();
    _descriptionStream.listen((description) {
      setState(() {
        _controller.text = description;
      });
    });
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
          title: const Text('Change Description'),
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
                      'Edit your description and keep in mind that this information is visible to other users',
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
                          ? 'Description cannot be empty'
                          : null,
                      controller: _controller,
                      enableSuggestions: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[250],
                        labelText: 'New description',
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
                        updateDescription();
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
                          updateDescription();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Update Description',
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

  void updateDescription() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        await GlobalUserService().updateDescription(
          description: _controller.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Description updated successfully!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      } on Exception {
        await showErrorDialog(
          context,
          'Could not update description, please try again.',
        );
      }
    }
  }
}
