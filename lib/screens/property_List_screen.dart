import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/property_bloc.dart';
import '../blocs/property_event.dart';
import '../blocs/property_state.dart';
import '../models/property.dart';
import '../widgets/property_card.dart';
import 'add_property_screen.dart';
import 'property_details_screen.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({Key? key}) : super(key: key);

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the FetchProperties event to load properties when the screen initializes
    context.read<PropertyBloc>().add(FetchProperties());
  }

  void _navigateToAddProperty() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyScreen(
          onSave: (property) {
            // Trigger the AddProperty event
            context.read<PropertyBloc>().add(AddProperty(property));
          },
        ),
      ),
    );
  }

  void _navigateToUpdateProperty(Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPropertyScreen(
          property: property,
          onSave: (updatedProperty) {
            // Trigger the UpdateProperty event
            context
                .read<PropertyBloc>()
                .add(UpdateProperty(property.id!, updatedProperty));
          },
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
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            final properties = state.properties;
            return properties.isEmpty
                ? const Center(
                    child: Text("No properties available. Add some!"))
                : ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return GestureDetector(
                        onTap: () => _navigateToPropertyDetails(property),
                        child: PropertyCard(
                          property: property,
                          onEdit: () => _navigateToUpdateProperty(property),
                          onDelete: () {
                            // Trigger the DeleteProperty event
                            context
                                .read<PropertyBloc>()
                                .add(DeleteProperty(property.id!));
                          },
                        ),
                      );
                    },
                  );
          } else if (state is PropertyError) {
            return Center(
              child: Text("Failed to load properties: ${state.message}"),
            );
          }
          return const Center(child: Text("An unexpected error occurred."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProperty,
        child: const Icon(Icons.add),
      ),
    );
  }
}
