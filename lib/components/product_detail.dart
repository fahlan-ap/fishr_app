import 'package:fishr_app/components/rental_form.dart';
import 'package:flutter/material.dart';
import 'package:fishr_app/components/feature_tile.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String productName;
  final String price;
  final double rating;
  final int idPancing;

  const ProductDetail({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.productName,
    required this.price,
    this.rating = 4.8,
    required this.idPancing,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
            child: Image.network(imageUrl, height: size.height * 0.25),
          ),
          const SizedBox(height: 25),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "$brand $productName",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      children: const [
                        FeatureTile(
                          icon: Icons.straighten,
                          title: "Rod Length",
                          value: "2.1 m",
                        ),
                        FeatureTile(
                          icon: Icons.cached,
                          title: "Reel Type",
                          value: "Spinning",
                        ),
                        FeatureTile(
                          icon: Icons.linear_scale,
                          title: "Line Weight",
                          value: "10–20 lb",
                        ),
                        FeatureTile(
                          icon: Icons.link,
                          title: "Hook Size",
                          value: "#2",
                        ),
                        FeatureTile(
                          icon: Icons.layers,
                          title: "Material",
                          value: "Carbon Fiber",
                        ),
                        FeatureTile(
                          icon: Icons.settings,
                          title: "Gear Ratio",
                          value: "5.2:1",
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            Get.to(() => RentalForm(
                              idPancing: idPancing,
                              imageUrl: imageUrl,
                              productName: "$brand $productName",
                              price: price,
                            ))
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFA726),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Book now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
