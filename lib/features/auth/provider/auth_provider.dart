import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    return _runAuthAction(
      () => _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      ),
    );
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final credential = await _runAuthAction(
      () => _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );

    final name = displayName?.trim();
    if (credential?.user != null && name != null && name.isNotEmpty) {
      await credential!.user!.updateDisplayName(name);
      await credential.user!.reload();
    }
    return credential;
  }

  Future<void> sendPasswordReset(String email) async {
    await _runAuthAction(
      () => _auth.sendPasswordResetEmail(email: email.trim()),
    );
  }

  Future<void> signOut() async {
    await _runAuthAction(_auth.signOut);
  }

  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  Future<T?> _runAuthAction<T>(Future<T> Function() action) async {
    _setLoading(true);
    _error = null;
    notifyListeners();
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      _error = _friendlyMessage(e);
      notifyListeners();
    } catch (e) {
      _error = 'Something went wrong. Please try again.';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
    return null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _friendlyMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'That email is already registered.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
