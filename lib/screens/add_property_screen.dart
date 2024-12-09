import 'package:flutter/material.dart';
import '../models/property.dart';

class AddPropertyScreen extends StatefulWidget {
  final Property? property; // Optional for update
  final Function(Property property) onSave;

  const AddPropertyScreen({Key? key, this.property, required this.onSave}) : super(key: key);

  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imagesController = TextEditingController();

  late String title, description, address, status;
  late double price;
  late int bedrooms, bathrooms, squareFeet;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    if (widget.property != null) {
      // Populate fields for update
      title = widget.property!.title;
      description = widget.property!.description;
      price = widget.property!.price;
      address = widget.property!.address;
      bedrooms = widget.property!.bedrooms;
      bathrooms = widget.property!.bathrooms;
      squareFeet = widget.property!.squareFeet;
      status = widget.property!.status;
      images = widget.property!.images;
      _imagesController.text = images.join(',');
    } else {
      // Initialize empty values for add
      title = description = address = status = '';
      price = 0.0;
      bedrooms = bathrooms = squareFeet = 0;
      images = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.property == null ? "Add Property" : "Update Property")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(labelText: "Title"),
              onSaved: (value) => title = value!,
            ),
            TextFormField(
              initialValue: description,
              decoration: const InputDecoration(labelText: "Description"),
              onSaved: (value) => description = value!,
            ),
            TextFormField(
              initialValue: price.toString(),
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              onSaved: (value) => price = double.parse(value!),
            ),
            TextFormField(
              initialValue: address,
              decoration: const InputDecoration(labelText: "Address"),
              onSaved: (value) => address = value!,
            ),
            TextFormField(
              initialValue: bedrooms.toString(),
              decoration: const InputDecoration(labelText: "Bedrooms"),
              keyboardType: TextInputType.number,
              onSaved: (value) => bedrooms = int.parse(value!),
            ),
            TextFormField(
              initialValue: bathrooms.toString(),
              decoration: const InputDecoration(labelText: "Bathrooms"),
              keyboardType: TextInputType.number,
              onSaved: (value) => bathrooms = int.parse(value!),
            ),
            TextFormField(
              initialValue: squareFeet.toString(),
              decoration: const InputDecoration(labelText: "Square Feet"),
              keyboardType: TextInputType.number,
              onSaved: (value) => squareFeet = int.parse(value!),
            ),
            TextFormField(
              controller: _imagesController,
              decoration: const InputDecoration(labelText: "Images (comma-separated URLs)"),
              onSaved: (value) => images = value!.split(','),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSave(
                    Property(
                      title: title,
                      description: description,
                      price: price,
                      address: address,
                      bedrooms: bedrooms,
                      bathrooms: bathrooms,
                      squareFeet: squareFeet,
                      status: status,
                      images: images,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
