import 'package:flutter/material.dart';
import 'package:assignment/services/db_service.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductService productService = ProductService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _stocksController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _marginController = TextEditingController();
  final _excTaxController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _mrpController = TextEditingController();
  final _descriptionController = TextEditingController();

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
  void initState() {
    super.initState();
    _purchasePriceController.addListener(_calculateMRP);
    _marginController.addListener(_calculateMRP);
  }

  void _calculateMRP() {
    final purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0.0;
    final margin = double.tryParse(_marginController.text) ?? 0.0;
    final mrp = (purchasePrice * (margin / 100)) + purchasePrice;
    _mrpController.text = mrp.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productCodeController.dispose();
    _stocksController.dispose();
    _manufacturerController.dispose();
    _marginController.dispose();
    _excTaxController.dispose();
    _purchasePriceController.dispose();
    _mrpController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final productCode = _productCodeController.text;
      final margin = double.tryParse(_marginController.text) ?? 0.0;
      final purchasePrice =
          double.tryParse(_purchasePriceController.text) ?? 0.0;
      final stocks = double.tryParse(_stocksController.text) ?? 0.0;
      final manufacturer = _manufacturerController.text;
      final excTax = double.tryParse(_excTaxController.text) ?? 0.0;
      final mrp = double.tryParse(_mrpController.text) ?? 0.0;
      final description = _descriptionController.text;

      productService
          .saveProduct(
              name: name,
              productCode: productCode,
              stocks: stocks,
              manufacturer: manufacturer,
              margin: margin,
              excTax: excTax,
              purchasePrice: purchasePrice,
              mrp: mrp,
              description: description,
              category: selectedCategory,
              brand: selectedBrand,
              unit: selectedUnit ?? '',
              warehouse: selectedWarehouse ?? '',
              tax: selectedTax ?? '',
              taxType: selectedTaxType ?? '')
          .then((_) => Navigator.pop(context))
          .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving product: $error")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () {
              // Implement bulk upload functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(
                    "Product Name", _nameController, "Enter Product Name",
                    required: true),
                buildDropdown("Category", selectedCategory, categories,
                    (value) {
                  setState(() => selectedCategory = value);
                }),
                buildDropdown("Brand", selectedBrand, brands, (value) {
                  setState(() => selectedBrand = value);
                }),
                buildTextField("Product Code", _productCodeController,
                    "Enter Product Code",
                    required: true),
                Row(
                  children: [
                    Expanded(
                      child: buildTextField(
                          "Stocks", _stocksController, "Enter Stocks"),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          buildDropdown("Units", selectedUnit, units, (value) {
                        setState(() => selectedUnit = value);
                      }),
                    ),
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
                Row(
                  children: [
                    Expanded(
                      child: buildTextField(
                        "Exc. Tax",
                        _excTaxController,
                        "Exc. Tax",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildTextField(
                          "Margin %", _marginController, "Margin %",
                          required: true),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildTextField("Purchase Price",
                          _purchasePriceController, "Enter Purchase Price",
                          required: true),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildTextField(
                          "MRP", _mrpController, "Auto-calculated MRP",
                          required: true, enabled: false),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                buildTextField(
                    "Description", _descriptionController, "Description",
                    maxLines: 3),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: GestureDetector(
                    onTap: _saveProduct,
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Text(
                          'Save Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, String hint,
      {bool enabled = true, int maxLines = 1, bool required = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        keyboardType: enabled ? TextInputType.number : null,
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              }
            : null,
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
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
      ),
    );
  }
}
