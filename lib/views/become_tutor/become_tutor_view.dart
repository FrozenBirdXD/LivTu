import 'package:flutter/material.dart';

class BecomeTutorView extends StatefulWidget {
  const BecomeTutorView({super.key});

  @override
  State<BecomeTutorView> createState() => _BecomeTutorViewState();
}

class _BecomeTutorViewState extends State<BecomeTutorView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _qualificationsController =
      TextEditingController();
  final TextEditingController _certificationsController =
      TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _experienceController.dispose();
    _qualificationsController.dispose();
    _certificationsController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data and submit the application
      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String subject = _subjectController.text;
      String experience = _experienceController.text;
      String qualifications = _qualificationsController.text;
      String certifications = _certificationsController.text;
      String skills = _skillsController.text;

      // Perform your application submission logic here

      // Reset the form fields
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _subjectController.clear();
      _experienceController.clear();
      _qualificationsController.clear();
      _certificationsController.clear();
      _skillsController.clear();

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Application Submitted'),
          content:
              Text('Thank you, $name! Your application has been submitted.'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Tutor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      'Become a Tutor',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'As a tutor, you will have the opportunity to help other students by sharing your knowledge and expertise.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Requirements:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                        '- Must be a current student at [Your University/School]'),
                    Text(
                        '- Proficient in the subject(s) you wish to teach - min. Grade B'),
                    Text('- Good communication and interpersonal skills'),
                    SizedBox(height: 16),
                    Text(
                      'Benefits of being a tutor:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('- Earn money by helping others'),
                    Text('- Gain valuable teaching and leadership experience'),
                    Text(
                        '- Enhance your understanding of the subject through teaching'),
                    SizedBox(height: 16),
                    Text(
                      'To become a tutor, please fill out the application form:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add email validation logic if required
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Add phone number validation logic if required
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextFormField(
                controller: _subjectController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the subject you want to teach';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Subject',
                ),
              ),
              TextFormField(
                controller: _experienceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your tutoring experience';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Tutoring Experience',
                ),
                maxLines: 3,
              ),
              TextFormField(
                controller: _qualificationsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your qualifications';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Qualifications',
                ),
                maxLines: 3,
              ),
              TextFormField(
                controller: _certificationsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your certifications';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Certifications',
                ),
                maxLines: 3,
              ),
              TextFormField(
                controller: _skillsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your skills';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Skills',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Apply Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
