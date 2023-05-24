import 'package:flutter/material.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I reset my password?',
      answer: 'To reset your password, go to the login screen and click on the "Forgot password" button. Follow the instructions provided to reset your password.',
    ),
    FAQItem(
      question: 'How can I change my profile picture?',
      answer: 'To change your profile picture, go to your profile and click on your current profile image. From there, you can upload a new profile picture.',
    ),
    FAQItem(
      question: 'What payment methods do you accept?',
      answer: 'We accept major credit cards such as Visa, Mastercard, and American Express. We also support payments through PayPal.',
    ),
    // Add more FAQ items as needed
  ];

  String contactName = 'LivTu Support Team';
  String contactEmail = 'Livtu@gmx.net';
  String contactPhoneNumber = '+49 111 11111111';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'FAQ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(faqItems[index].question),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(faqItems[index].answer),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: Text(contactName),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(contactEmail),
              onTap: () {
                // TODO: Implement email functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: Text(contactPhoneNumber),
              onTap: () {
                // TODO: Implement phone call functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}