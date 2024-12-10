import 'package:dio/dio.dart';
import '../models/property.dart';

class PropertyRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api'));

  Future<List<Property>> fetchProperties() async {
    final response = await _dio.get('/properties');
    return (response.data as List)
        .map((json) => Property.fromJson(json))
        .toList();
  }

  Future<void> createProperty(Property property) async {
    try {
      // Ensure the price is an integer before sending it
      final data = property.toJson();
      data['price'] = int.tryParse(data['price'].toString()) ?? 0;

      await _dio.post('/properties', data: data);
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
    }
  }

  Future<void> updateProperty(int id, Property property) async {
    try {
      // Ensure the price is an integer before sending it
      final data = property.toJson();
      data['price'] = int.tryParse(data['price'].toString()) ?? 0;

      await _dio.patch('/properties/$id', data: data);
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
    }
  }

  Future<void> deleteProperty(int id) async {
    await _dio.delete('/properties/$id');
  }

  Future<Property> fetchPropertyById(int id) async {
    final response = await _dio.get('/properties/$id');
    return Property.fromJson(response.data);
  }
}
