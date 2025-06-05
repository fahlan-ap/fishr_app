import 'package:flutter/material.dart';
import 'package:fishr_app/components/product_detail.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String productName;
  final String price;
  final int idPancing; // id disimpan tapi tidak ditampilkan

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.productName,
    required this.price,
    required this.idPancing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetail(
              imageUrl: imageUrl,
              brand: brand,
              productName: productName,
              price: price,
              idPancing: idPancing,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.network(imageUrl, height: 80, width: 80, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(brand, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}