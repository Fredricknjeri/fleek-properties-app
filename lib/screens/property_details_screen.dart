import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/property.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider for Property Images
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: property.images!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    property.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.redAccent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          property.address,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Price
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.green),
                      const SizedBox(width: 10),
                      Text(
                        "\$${property.price}",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Bedrooms and Bathrooms
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureIcon(
                        context,
                        icon: Icons.bed,
                        value: property.bedrooms.toString(),
                        label: "Bedrooms",
                      ),
                      _buildFeatureIcon(
                        context,
                        icon: Icons.bathtub,
                        value: property.bathrooms.toString(),
                        label: "Bathrooms",
                      ),
                      _buildFeatureIcon(
                        context,
                        icon: Icons.square_foot,
                        value: "${property.squareFeet} sqft",
                        label: "Size",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Status
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blueAccent),
                      const SizedBox(width: 10),
                      Text(
                        property.status,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 32),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
