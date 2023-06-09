# LivTu - Tutoring Platform

LivTu is a tutoring platform that aims to connect students with qualified tutors for personalized learning experiences. This repository contains the proof of concept for the LivTu platform.

**Note: This proof of concept is not supported or functional as a real tutoring platform. It serves as a demonstration of the business idea.**

## Introduction

The LivTu Tutoring Platform aims to change how students connect with tutors. Our platform has an easy-to-use interface that helps students find tutors who specialize in the subjects they need help with. Moreover, LivTu offers students 
the chance to become tutors, creating a great community of learners. This repository demonstrates the initial version of the LivTu platform to showcase its concept and functionality.

## Features
The LivTu Tutoring Platform proof of concept includes the following features:

- User registration, login, forgot password etc.: Users can create accounts and log in to the platform.

- Personalized profile pages: Users can set their own username, change profile and background picture, add a description of themselves, add subjects of interest.

- Opportunity for students to become tutors: Users can submit an application to become a tutor.

- Support Page: FAQ section with answers to most questions and contact information.

- Settings: Users can change their username and password.

- Languages: English and German are both supported by LivTu.

- Schedule/Calendar: Users have access to their own calendar in a day, week, month and schedule format. Custom events can be created and display in the calendar.

- Community-building features: This encourages interaction and collaboration among students, creating a supportive and engaging community. Users can browse through the profiles of tutors and other students, gaining insights into their expertise and interests. If a user wants to schedule a tutoring session with a tutor, they can easily message them to discuss the details. Similarly, users can connect with other students, fostering connections and opportunities for group study or knowledge sharing. 

    - View tutor profiles and qualifications: Users can access detailed tutor profiles that provide information about their qualifications, expertise, and teaching experience. This feature helps students make informed decisions when choosing a tutor.

**Please note that while these features are demonstrated in the proof of concept, they many not be fully functional or integrated into a live tutoring platform.**

## Screenshots
Here are a few screenshots showcasing the user interface of the LivTu Tutoring Platform:

<table>
  <tr>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/48bb326a-3f3e-4c8d-9ef9-45aad468a7de" alt="Screenshot 1" width="250">
    </td>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/771f60de-fb2d-4ab1-a3b7-4b923eb30070" alt="Screenshot 2" width="250">
    </td>
     <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/cedd0e6e-a87f-486c-b0ec-23b0f6fa9eae" alt="Screenshot 5" width="250">
    </td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/fa94752f-faf2-4ec5-ba3f-b75f882b3fc9" alt="Screenshot 3" width="250">
    </td>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/e15dc38d-a9e1-4c82-9c8a-b5d8131254b4" alt="Screenshot 4" width="250">
    </td>
     <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/d84d1802-333d-4f2d-9810-06f2fc349779" alt="Screenshot 6" width="250">
    </td>
  </tr>
   <tr>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/931b01c6-9b94-4516-8b65-64f5d65ec403" alt="Screenshot 7" width="250">
    </td>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/294377f1-d090-4154-99de-428a53c75f68" alt="Screenshot 8" width="250">
    </td>
     <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/8414e6ca-d83f-4777-a91f-590a61731403" alt="Screenshot 9" width="250">
    </td>
  </tr>
   <tr>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/dbc77c78-e6ff-435e-8c60-797874a392c1" alt="Screenshot 10" width="250">
    </td>
    <td>
      <img src="https://github.com/FrozenBirdXD/LivTu/assets/118717731/e623d6c6-4667-4341-9cfc-e726f046ddd0" alt="Screenshot 11" width="250">
    </td>
  </tr>
</table>

## Technologies
The LivTu Tutoring Platform proof of concept is built using the following technologies:
- Flutter: A UI toolkit from Google. The project uses Flutter version 3.10.0.
- Dart: A programming language developed by Google. The project uses Dart version 3.0.0.
- Firebase: Backend-as-a-Service (BaaS) from Google. The project utilizes the following Firebase services and packages:
 
    - Firebase Authentication (version 4.6.0): User authentication with ready-to-use features.
    - Firebase Core (version 2.12.0): Provides the core functionality for Firebase services.
    - Firebase Crashlytics (version 3.3.0): Enables crash reporting and analysis for the app.
    - Cloud Firestore (version 4.7.0): NoSQL document database for storing and syncing app data.
    - Firebase Storage (version 11.2.1): An object storage solution for storing user-uploaded files.

Other libraries and packages used in the project (from [pub.dev](https://pub.dev/)):

- bloc (version 8.1.1) and flutter_bloc (version 8.1.2): State management.
- equatable (version 2.0.5): Simplifies equality comparisons for Dart objects.
- intl: Supports internationalization and localization in the app (German and English).
- syncfusion_flutter_calendar (version 21.2.5): Renders a customizable calendar widget.
- provider (version 6.0.5): Provider pattern for state management.
- shared_preferences (version 2.1.1): Stores app preferences and settings.
- image_picker (version 0.8.7+5): Allows users to pick images from their device's gallery or camera.
- flutter_test (dev_dependency): Provides testing tools and utilities for Flutter applications.
- flutter_lints (dev_dependency version 2.0.0): Lint rules and configurations for static analysis of the codebase.

## License
[MIT](https://github.com/FrozenBirdXD/LivTu/blob/master/LICENSE)
