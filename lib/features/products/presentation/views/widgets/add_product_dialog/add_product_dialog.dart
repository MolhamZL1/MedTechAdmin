import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProductAddDialog extends StatefulWidget {
  const ProductAddDialog({super.key});

  @override
  State<ProductAddDialog> createState() => _ProductAddDialogState();
}

class _ProductAddDialogState extends State<ProductAddDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameEnController = TextEditingController();
  final nameArController = TextEditingController();
  final categoryEnController = TextEditingController();
  final categoryArController = TextEditingController();
  final companyEnController = TextEditingController();
  final companyArController = TextEditingController();
  final descEnController = TextEditingController();
  final descArController = TextEditingController();
  final rentStockController = TextEditingController();
  final saleStockController = TextEditingController();
  final salePriceController = TextEditingController();
  final rentalPriceController = TextEditingController();
  final rateController = TextEditingController();

  bool availableForRent = false;
  bool availableForSale = false;

  List imageFiles = [];
  List videoFiles = [];

  Future<void> pickImages() async {}

  Future<void> pickVideos() async {}

  void submit() {
    if (_formKey.currentState!.validate()) {
      // You can construct your ProductEntity here and return it or send to backend.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
      ),
      title: const Text(
        "Add New Product",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 800,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildTextField(nameEnController, "Name (EN)"),
                _buildTextField(nameArController, "Name (AR)"),
                _buildTextField(categoryEnController, "Category (EN)"),
                _buildTextField(categoryArController, "Category (AR)"),
                _buildTextField(companyEnController, "Company (EN)"),
                _buildTextField(companyArController, "Company (AR)"),
                _buildTextField(
                  descEnController,
                  "Description (EN)",
                  maxLines: 2,
                ),
                _buildTextField(
                  descArController,
                  "Description (AR)",
                  maxLines: 2,
                ),
                _buildTextField(
                  rentStockController,
                  "Rent Stock",
                  isNumber: true,
                ),
                _buildTextField(
                  saleStockController,
                  "Sale Stock",
                  isNumber: true,
                ),
                _buildTextField(
                  salePriceController,
                  "Sale Price",
                  isNumber: true,
                ),
                _buildTextField(
                  rentalPriceController,
                  "Rental Price",
                  isNumber: true,
                ),
                _buildTextField(rateController, "Rate", isNumber: true),

                Row(
                  children: [
                    Checkbox(
                      value: availableForRent,
                      onChanged: (v) => setState(() => availableForRent = v!),
                    ),
                    const Text("Available for Rent"),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: availableForSale,
                      onChanged: (v) => setState(() => availableForSale = v!),
                    ),
                    const Text("Available for Sale"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          onPressed: submit,
          label: const Text("Add Product"),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : null,
        decoration: InputDecoration(labelText: label),
        validator:
            (value) => value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }
}
