import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:final_bloc_example/auth/auth_error.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;
  const AppState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;
  const AppStateLoggedIn({
    required this.user,
    required this.images,
    required super.isLoading,
    required super.authError,
  });

  @override
  bool operator ==(other) {
    if (other is AppStateLoggedIn) {
      return other.isLoading == isLoading &&
          other.user.uid == user.uid &&
          other.images.length == images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        isLoading,
        images,
      );

  @override
  String toString() {
    return "AppState Logged In, image.length = ${images.length}";
  }
}

@immutable
class AppStateLoggedOut extends AppState {
  final String? test;
  const AppStateLoggedOut(this.test, {
    required super.isLoading,
    required super.authError,
  });

  @override
  String toString() {
    return "AppState Logged Out, isLoading = $isLoading, authError = $authError";
  }
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView({
    required super.isLoading,
    required super.authError,
  });
}

extension GetUser on AppState {
  User? get user {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AppState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
