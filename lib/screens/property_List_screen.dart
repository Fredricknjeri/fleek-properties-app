import 'package:flutter/material.dart';
import 'add_property_screen.dart';
import '../widgets/property_card.dart';
import '../models/property.dart';
import 'property_details_screen.dart';


class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({Key? key}) : super(key: key);

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final List<Property> _properties = [];

  void _addProperty(Property property) {
    setState(() {
      _properties.add(property);
    });
  }

  void _updateProperty(int index, Property updatedProperty) {
    setState(() {
      _properties[index] = updatedProperty;
    });
  }

  void _deleteProperty(int index) {
    setState(() {
      _properties.removeAt(index);
    });
  }

  void _navigateToAddProperty() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyScreen(
          onSave: (property) => _addProperty(property),
        ),
      ),
    );
  }

  void _navigateToUpdateProperty(int index, Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyScreen(
          property: property,
          onSave: (updatedProperty) => _updateProperty(index, updatedProperty),
        ),
      ),
    );
  }

  void _navigateToPropertyDetails(Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailsScreen(property: property),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Property List"),
      ),
      body: _properties.isEmpty
          ? const Center(
              child: Text("No properties available. Add some!"),
            )
          : ListView.builder(
              itemCount: _properties.length,
              itemBuilder: (context, index) {
                final property = _properties[index];
                return GestureDetector(
                  onTap: () => _navigateToPropertyDetails(property),
                  child: PropertyCard(
                    property: property,
                    onEdit: () => _navigateToUpdateProperty(index, property),
                    onDelete: () => _deleteProperty(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProperty,
        child: const Icon(Icons.add),
      ),
    );
  }
}
