import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, Map<String, dynamic> user);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<User> getCurrentUserId();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<User> getCurrentUserId() async {
    return await supabaseClient.auth.currentUser!;
  }

  @override
  Future<bool> isSignedIn() async {
    return await supabaseClient.auth.currentUser != null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final respone = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (respone.user == null) {
        throw Exception('User not found');
      }
      return respone.user!;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<User> signUp(
    String email,
    String password,
    Map<String, dynamic> user,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: user,
      );
      return response.user!;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
