class Property {
  final String title;
  final String description;
  final double price;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int squareFeet;
  final String status;
  final List<String> images;

  Property({
    required this.title,
    required this.description,
    required this.price,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFeet,
    required this.status,
    required this.images,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      squareFeet: json['square_feet'],
      status: json['status'],
      images: List<String>.from(json['images']), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'address': address,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'square_feet': squareFeet,
      'status': status,
      'images': images, 
    };
  }
}
