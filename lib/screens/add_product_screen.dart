import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Controllers for TextFormFields
  final _nameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _stocksController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _marginController = TextEditingController();
  final _excTaxController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _mrpController = TextEditingController();

  // Dropdown values
  String? selectedCategory;
  String? selectedBrand;
  String? selectedUnit;
  String? selectedWarehouse;
  String? selectedTax;
  String? selectedTaxType;

  // Sample options
  final List<String> categories = [
    "Electronics",
    "Clothing",
    "Home Appliances"
  ];
  final List<String> brands = ["Brand A", "Brand B", "Brand C"];
  final List<String> units = ["Piece", "Kg", "Liter"];
  final List<String> warehouses = ["InHouse", "External"];
  final List<String> taxes = ["5%", "12%", "18%"];
  final List<String> taxTypes = ["Exclusive", "Inclusive"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              // Implement bulk upload functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(
                  "Product Name", _nameController, "Enter Product Name"),
              buildDropdown("Category", selectedCategory, categories, (value) {
                setState(() => selectedCategory = value);
              }),
              buildDropdown("Brand", selectedBrand, brands, (value) {
                setState(() => selectedBrand = value);
              }),
              buildTextField("Product Code", _productCodeController,
                  "Enter Product Code or Scan"),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          "Stocks", _stocksController, "Enter Stocks")),
                  SizedBox(width: 10),
                  Expanded(
                      child:
                          buildDropdown("Units", selectedUnit, units, (value) {
                    setState(() => selectedUnit = value);
                  })),
                ],
              ),
              buildTextField("Manufacturer", _manufacturerController,
                  "Enter Manufacturer"),
              buildDropdown("Warehouse", selectedWarehouse, warehouses,
                  (value) {
                setState(() => selectedWarehouse = value);
              }),
              buildDropdown("Applicable Tax", selectedTax, taxes, (value) {
                setState(() => selectedTax = value);
              }),
              buildDropdown("Tax Type", selectedTaxType, taxTypes, (value) {
                setState(() => selectedTaxType = value);
              }),
              buildRowFields(),
              buildTextField("Purchase Price", _purchasePriceController,
                  "Enter Purchase Price"),
              buildTextField("MRP", _mrpController, "Enter MRP/Retail Price"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black),
                  child: const Center(
                    child: Text(
                      'Save Product',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, String? selectedValue, List<String> items,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildRowFields() {
    return Row(
      children: [
        Expanded(
          child: buildTextField("Margin", _marginController, "Enter Margin"),
        ),
        SizedBox(width: 10),
        Expanded(
          child:
              buildTextField("Exc. Tax", _excTaxController, "Enter Exc. Tax"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _productCodeController.dispose();
    _stocksController.dispose();
    _manufacturerController.dispose();
    _marginController.dispose();
    _excTaxController.dispose();
    _purchasePriceController.dispose();
    _mrpController.dispose();
    super.dispose();
  }
}
