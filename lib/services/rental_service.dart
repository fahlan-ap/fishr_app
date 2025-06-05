import 'package:supabase_flutter/supabase_flutter.dart';

class RentalService {
  final supabase = Supabase.instance.client;

  Future<void> createRental({
    required int idPancing,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await supabase.from('rental').insert({
      'id_pancing': idPancing,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    });

    if (response != null && response.error != null) {
      throw response.error!.message;
    }
  }
}