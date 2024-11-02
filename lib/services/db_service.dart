import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      // Add product to Firestore and get the document reference
      DocumentReference docRef = await _firestore.collection('products').add({
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

      // Update the document with its ID
      await docRef.update({'productId': docRef.id});

      print("Product saved successfully with ID: ${docRef.id}!");
    } catch (e) {
      print("Failed to save product: $e");
      throw e; // Re-throw the error for further handling if needed
    }
  }

  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> deleteProduct(String productId, BuildContext context) async {
    try {
      await _productsCollection.doc(productId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $e')),
      );
    }
  }
}
