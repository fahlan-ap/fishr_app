import 'package:supabase_flutter/supabase_flutter.dart';

class RentalService {
  final SupabaseClient _supabase = Supabase.instance.client;

  String get _currentUserId {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception("User not logged in");
    }
    return userId;
  }

  Future<void> createRental({
    required int idPancing,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await _supabase.from('rental').insert({
      'id_pancing': idPancing,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'user_id': _currentUserId,
    });
  }

  Future<Map<String, dynamic>?> getLatestRental() async {
    final response = await _supabase
        .from('rental')
        .select()
        .eq('user_id', _currentUserId)
        .order('id', ascending: false)
        .limit(1)
        .maybeSingle();

    return response;
  }

  Future<void> deleteRental(int rentalId) async {
    await _supabase.from('rental').delete().eq('id', rentalId);
  }
}