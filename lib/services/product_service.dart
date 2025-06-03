import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabase.from('pancing').select();
    return List<Map<String, dynamic>>.from(response);
  }

  String getPublicImageUrl(String imagePath) {
    return supabase.storage.from('images').getPublicUrl(imagePath);
  }
}