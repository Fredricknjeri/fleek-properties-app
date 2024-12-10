import 'package:flutter/material.dart';
import '../models/property.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPropertyScreen extends StatefulWidget {
  final Property? property; // Optional for update
  final Function(Property property) onSave;

  const AddPropertyScreen({Key? key, this.property, required this.onSave})
      : super(key: key);

  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imagesController = TextEditingController();

  late String title, description, address, status;
  late String price;
  late int bedrooms, bathrooms, squareFeet;
  late List<String> images;
  final ImagePicker _picker = ImagePicker();
  List<File> _pickedImages = [];
  final List<String> statusOptions = ['available', 'rented', 'FOR SALE'];

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
      images = widget.property!.images!;
      _imagesController.text = images.join(',');
    } else {
      // Initialize empty values for add
      title = description = address = status = '';
      price = "0.0";
      bedrooms = bathrooms = squareFeet = 0;
      images = [];
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _pickedImages.addAll(pickedFiles.map((file) => File(file.path)));
    });
  }

  void _addImageUrl() {
    if (_imagesController.text.isNotEmpty) {
      setState(() {
        images.add(_imagesController.text.trim());
        _imagesController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.property == null ? "Add Property" : "Update Property"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStyledTextFormField(
                label: 'Title',
                initialValue: title,
                onSaved: (value) => title = value!,
              ),
              _buildStyledTextFormField(
                label: 'Description',
                initialValue: description,
                maxLines: 3,
                onSaved: (value) => description = value!,
              ),
              _buildStyledTextFormField(
                label: 'Price',
                initialValue: price.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => price = value!,
              ),
              _buildStyledTextFormField(
                label: 'Address',
                initialValue: address,
                onSaved: (value) => address = value!,
              ),
                   Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DropdownButtonFormField<String>(
                  value: status,
                  items: statusOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      status = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || !statusOptions.contains(value)) {
                      return 'Please select a valid status';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              _buildStyledTextFormField(
                label: 'Bedrooms',
                initialValue: bedrooms.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => bedrooms = int.parse(value!),
              ),
              _buildStyledTextFormField(
                label: 'Bathrooms',
                initialValue: bathrooms.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => bathrooms = int.parse(value!),
              ),
              _buildStyledTextFormField(
                label: 'Square Feet',
                initialValue: squareFeet.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => squareFeet = int.parse(value!),
              ),

              // Images Section
              const SizedBox(height: 20),
              const Text(
                'Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: 410,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera),
                      label: const Text(''),
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton.icon(
                      onPressed: _uploadFromGallery,
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: _pickedImages
                    .map((file) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              _buildStyledTextFormField(
                label: 'Add Image URL',
                controller: _imagesController,
                onSaved: (_) {},
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _addImageUrl,
                  icon: const Icon(Icons.add_link),
                  label: const Text('Add URL'),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: images
                    .map((url) => Chip(
                          label: Text(url),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => setState(() => images.remove(url)),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onSave(
                        Property(
                          title: title,
                          description: description,
                          price: price.toString(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextFormField({
    required String label,
    String? initialValue,
    TextInputType? keyboardType,
    int maxLines = 1,
    TextEditingController? controller,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        onSaved: onSaved,
      ),
    );
  }
}
