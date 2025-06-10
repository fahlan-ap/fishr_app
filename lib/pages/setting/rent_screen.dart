import 'package:flutter/material.dart';
import 'package:fishr_app/services/rental_service.dart';
import 'package:fishr_app/services/product_service.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({super.key});

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  Map<String, dynamic>? _rentalData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRentalData();
  }

  Future<void> _fetchRentalData() async {
    try {
      final rental = await RentalService().getLatestRental();
      if (rental != null) {
        final product = await ProductService().getProductById(rental['id_pancing']);
        setState(() {
          _rentalData = {
            ...rental,
            'product': product,
          };
        });
      }
    } catch (e) {
      debugPrint("Error fetching rental data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleReturnRental(int rentalId) async {
    try {
      await RentalService().deleteRental(rentalId);
      setState(() {
        _rentalData = null;
      });

      _showSnackBar("Penyewaan telah dikembalikan.");
    } catch (e) {
      _showSnackBar("Gagal mengembalikan penyewaan: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildRentalInfo() {
    final product = _rentalData!['product'];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Produk Preview
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ProductService().getPublicImageUrl(product['image_path']),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['type'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text("Brand: ${product['brand']}"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Informasi Rental
          ListTile(
            title: const Text("Start Date"),
            subtitle: Text(_rentalData!['start_date'].toString().split(" ")[0]),
          ),
          ListTile(
            title: const Text("End Date"),
            subtitle: Text(_rentalData!['end_date'].toString().split(" ")[0]),
          ),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Status: Active",
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),

          const Spacer(),

          // Tombol Return
          ElevatedButton(
            onPressed: () => _handleReturnRental(_rentalData!['id']),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: const Text("Return Now", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rental Active"),
        backgroundColor: const Color(0xFF012748),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _rentalData == null
              ? const Center(child: Text("Tidak ada penyewaan aktif."))
              : _buildRentalInfo(),
    );
  }
}