import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  /// Permanently deletes the currently signed-in user's account.
  ///
  /// Returns `true` on success. If Firebase requires a fresh login before
  /// deletion, [error] is set to a friendly message and `false` is returned.
  Future<bool> deleteAccount() async {
    final result = await _runAuthAction(() async {
      final user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-current-user',
          message: 'No account is currently signed in.',
        );
      }
      await user.delete();
      return true;
    });
    return result ?? false;
  }

  Future<UserCredential?> signInWithGoogle() async {
    return _runAuthAction(() async {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('email');
        provider.setCustomParameters({'login_hint': 'user@example.com'});
        return _auth.signInWithPopup(provider);
      }
      final GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(
        // clientId:
        //     '936659046488-sv1cjeh6r3osf0fvls93jeeetf7326of.apps.googleusercontent.com',
        // serverClientId:
        //     '936659046488-sv1cjeh6r3osf0fvls93jeeetf7326of.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await signIn.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    });
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
      _error = e.toString();
      debugPrint(e.toString());
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
      case 'requires-recent-login':
        return 'For your security, please sign in again before deleting your account.';
      case 'no-current-user':
        return 'No account is currently signed in.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
