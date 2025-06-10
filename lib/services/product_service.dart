import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await _supabase.from('pancing').select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
    final response = await _supabase
        .from('pancing')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) {
      throw Exception('Produk dengan ID $id tidak ditemukan');
    }

    return response;
  }

  String getPublicImageUrl(String imagePath) {
    return _supabase.storage.from('images').getPublicUrl(imagePath);
  }
}