import 'package:assignment/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference for products
  CollectionReference get _productsCollection =>
      _firestore.collection('products');

  // Add a new product to Firestore
  Future<void> addProduct(Product product) async {
    try {
      await _productsCollection.add(product.toMap());
    } catch (e) {
      print("Failed to add product: $e");
      // Optionally handle the error or throw it
    }
  }

  // Update an existing product by its document ID
  Future<void> updateProduct(String productId, Product product) async {
    try {
      await _productsCollection.doc(productId).update(product.toMap());
    } catch (e) {
      print("Failed to update product: $e");
    }
  }

  // Delete a product by its document ID
  Future<void> deleteProduct(String productId) async {
    try {
      await _productsCollection.doc(productId).delete();
    } catch (e) {
      print("Failed to delete product: $e");
    }
  }

  // Get a stream of all products in the collection
  Stream<List<Product>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product.fromMap(data);
      }).toList();
    });
  }

  // Get a single product by its document ID
  Future<Product?> getProductById(String productId) async {
    try {
      final doc = await _productsCollection.doc(productId).get();
      if (doc.exists) {
        return Product.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Failed to get product: $e");
    }
    return null;
  }
}
