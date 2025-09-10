import 'package:choach_debate/features/Profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> fetchProfile();
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRemoteDataSourceImpl implements ProfileDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<ProfileModel> fetchProfile() async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw Exception('No authenticated user found');
      }

      final data = {
        'userName': user.userMetadata?['userName'] ?? '',
        'email': user.email ?? '',
        'institusi': user.userMetadata?['institusi'] ?? '',
      };

      return ProfileModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(
          email: profile.email,
          data: {'userName': profile.userName, 'institusi': profile.institusi},
        ),
      );
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
