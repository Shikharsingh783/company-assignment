import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String productCode;
  final double price;
  final String? imageUrl;
  final double stocks;
  final String productId; // ID of the product document
  final VoidCallback onDelete; // Callback for delete action

  const ProductTile({
    Key? key,
    required this.name,
    required this.stocks,
    required this.productCode,
    required this.price,
    this.imageUrl,
    required this.productId, // Initialize productId
    required this.onDelete, // Initialize the onDelete callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                )
              : const Icon(
                  Icons.shopping_bag,
                  size: 50,
                  color: Colors.grey,
                ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Code: $productCode',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Text(
                  'Stocks: ${stocks.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert), // Three-dot icon
          onSelected: (value) {
            if (value == 'delete') {
              // Call the onDelete callback if the delete option is selected
              onDelete();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
