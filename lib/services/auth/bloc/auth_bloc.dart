import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/services/auth/auth_provider.dart';
import 'package:livtu/services/auth/auth_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:livtu/services/profile/global_user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthUninitializedState(isLoading: true)) {
    // initialize event
    on<AuthInitEvent>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthLoggedOutState(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthNeedVerificationState(isLoading: false));
      } else {
        emit(AuthLoggedInState(
          user: user,
          isLoading: false,
        ));
      }
    });

    on<AuthGoToMainEvent>((event, emit) {
      emit(
        AuthLoggedInState(
          user: provider.currentUser!,
          isLoading: false,
        ),
      );
    });

    // send verification email
    on<AuthSendVerificationEmailEvent>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    // register event
    on<AuthRegisterEvent>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        GlobalUserService().createNewUser(newUserId: provider.currentUser!.id);

        emit(const AuthNeedVerificationState(isLoading: false));
      } on Exception catch (e) {
        emit(AuthRegisteringState(
          exception: e,
          isLoading: false,
        ));
      }
    });

    // forgot password event
    on<AuthForgotPasswordEvent>((event, emit) async {
      emit(const AuthForgotPasswordState(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      // just go to view
      if (email == null) {
        return;
      }
      // wants to reset password
      emit(const AuthForgotPasswordState(
        exception: null,
        hasSentEmail: false,
        isLoading: true,
      ));

      bool hasSentEmail;
      Exception? exception;
      // try reseting
      try {
        await provider.sendPasswordReset(email: email);
        hasSentEmail = true;
        exception = null;
      } on Exception catch (e) {
        hasSentEmail = false;
        exception = e;
      }

      emit(AuthForgotPasswordState(
        exception: exception,
        hasSentEmail: hasSentEmail,
        isLoading: false,
      ));
    });

    // should register event
    on<AuthShouldRegisterEvent>((event, emit) {
      emit(const AuthRegisteringState(
        exception: null,
        isLoading: false,
      ));
    });

    // login event
    on<AuthLoginEvent>((event, emit) async {
      emit(
        AuthLoggedOutState(
            exception: null,
            isLoading: true,
            loadingText:
                AppLocalizations.of(event.context)!.loginLoadingDialog),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          // disable loading screen
          emit(
            const AuthLoggedOutState(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AuthNeedVerificationState(isLoading: false));
        } else {
          // disable loading screen
          emit(
            const AuthLoggedOutState(
              exception: null,
              isLoading: false,
            ),
          );
          emit(AuthLoggedInState(
            user: user,
            isLoading: false,
          ));
        }
      } on Exception catch (e) {
        emit(
          AuthLoggedOutState(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });

    // logout event
    on<AuthLogoutEvent>((event, emit) async {
      try {
        await provider.logOut();
        emit(
          const AuthLoggedOutState(
            exception: null,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(
          AuthLoggedOutState(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
  }
}
