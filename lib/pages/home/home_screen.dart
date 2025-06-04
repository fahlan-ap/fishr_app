import 'package:flutter/material.dart';
import 'package:fishr_app/services/product_service.dart';
import 'package:fishr_app/components/brand_icon.dart';
import 'package:fishr_app/components/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFF012748),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 60,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Brands",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: const [
                  BrandIcon(imagePath: "assets/images/Exori.png"),
                  BrandIcon(imagePath: "assets/images/ShimanoFishing.jpg"),
                  BrandIcon(imagePath: "assets/images/Shakespeare.png"),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Deals",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      color: Color(0xFF012748),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: productService.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Tidak ada produk."),
                  );
                }

                final products = snapshot.data!;
                final limitedProducts = products.take(2).toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: limitedProducts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = limitedProducts[index];
                      final imageUrl = productService.getPublicImageUrl(product['image_path']);

                      return Column(
                        children: [
                          ProductCard(
                            imageUrl: imageUrl,
                            brand: product['brand'],
                            productName: product['type'],
                            price: "Rp ${product['price']}/hari",
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
