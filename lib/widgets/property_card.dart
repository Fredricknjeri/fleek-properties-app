import 'package:flutter/material.dart';
import '../models/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display images in a carousel
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: property.images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    property.images[index],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(property.description),
                Text("Price: \$${property.price}"),
                Text("Address: ${property.address}"),
                Text("${property.bedrooms} Bedrooms | ${property.bathrooms} Bathrooms"),
                Text("Size: ${property.squareFeet} sq. ft."),
                Text("Status: ${property.status}"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: onEdit,
                child: const Text("Edit"),
              ),
              ElevatedButton(
                onPressed: onDelete,
                child: const Text("Delete"),
                style: ElevatedButton.styleFrom(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
