import 'package:fypapp/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();
  Future<void> logOut();

}
