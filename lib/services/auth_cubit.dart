import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/services/cloud_backup_service.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSyncing extends AuthState {
  final User user;
  AuthSyncing(this.user);
}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        final user = data.session?.user;
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  final _cloudService = locator.get<CloudBackupService>();
  late final StreamSubscription<dynamic> _authSubscription;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await _cloudService.logInWithEmail(email: email, password: password);
      await syncNow();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    try {
      await _cloudService.signUpWithEmail(
        email: email,
        password: password,
        username: username,
      );
      await syncNow();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<bool> syncNow() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      emit(AuthUnauthenticated());
      return false;
    }

    emit(AuthSyncing(user));
    try {
      await _cloudService.syncData();
      emit(AuthAuthenticated(user));
      return true;
    } catch (e) {
      emit(AuthError('Sync failed: $e'));
      emit(AuthAuthenticated(user));
      return false;
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
