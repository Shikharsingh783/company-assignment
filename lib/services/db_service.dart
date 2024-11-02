// lib/services/product_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveProduct({
    required String name,
    required String productCode,
    required String manufacturer,
    required String description,
    required double stocks,
    required double margin,
    required double excTax,
    required double purchasePrice,
    required double mrp,
    required String? category,
    required String? brand,
    required String? unit,
    required String? warehouse,
    required String? tax,
    required String? taxType,
  }) async {
    try {
      await _firestore.collection('products').add({
        'name': name,
        'productCode': productCode,
        'manufacturer': manufacturer,
        'description': description,
        'stocks': stocks,
        'margin': margin,
        'excTax': excTax,
        'purchasePrice': purchasePrice,
        'mrp': mrp,
        'category': category,
        'brand': brand,
        'unit': unit,
        'warehouse': warehouse,
        'tax': tax,
        'taxType': taxType,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Product saved successfully!");
    } catch (e) {
      print("Failed to save product: $e");
      throw e; // Re-throw the error for further handling if needed
    }
  }
}
