import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/products/data/models/product_upload_model.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/cubit/add_media_cubit.dart';

import '../../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../../core/widgets/showsuccessDialog.dart';
import 'MediaUploadSection.dart';

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

  bool availableForRent = false;
  bool availableForSale = false;

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
            child: BlocBuilder<AddMediaCubit, AddMediaState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ..._buildTextFields(),
                    _buildAvailabilityCheckboxes(),
                    MediaUploadSection(
                      title: "Upload Images",
                      files: context.watch<AddMediaCubit>().imageFiles,
                      onUpload: context.read<AddMediaCubit>().addImage,
                      onDelete: context.read<AddMediaCubit>().removeImage,
                      isImage: true,
                    ),
                    MediaUploadSection(
                      title: "Upload Videos",
                      files: context.watch<AddMediaCubit>().videoFiles,
                      onUpload: context.read<AddMediaCubit>().addVideo,
                      onDelete: context.read<AddMediaCubit>().removeVideo,
                      isImage: false,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        BlocListener<AddProductCubit, AddProductState>(
          listener: (context, state) {
            if (state is AddProductLoading) {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AddProductError) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(); // Dismiss loading
              showerrorDialog(
                context: context,
                title: "Error",
                description: state.errMessage,
              );
            } else if (state is AddProductSuccess) {
              Navigator.of(context).pop(); // Dismiss loading

              showsuccessDialog(
                context: context,
                title: "Success",
                description:
                    "Product Added Successfully \n Refresh Page Please",
                btnOkOnPress: () {
                  Navigator.of(
                    context,
                  ).popUntil((route) => route.isFirst); // Dismiss Dialog
                },
              );
            }
          },
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final productUploadModel = ProductUploadModel(
                  nameEn: nameEnController.text,
                  nameAr: nameArController.text,
                  categoryEn: categoryEnController.text,
                  categoryAr: categoryArController.text,
                  companyEn: companyEnController.text,
                  companyAr: companyArController.text,
                  descriptionEn: descEnController.text,
                  rentStock: int.parse(rentStockController.text),
                  saleStock: int.parse(saleStockController.text),
                  salePrice: double.parse(salePriceController.text),
                  rentalPrice: double.parse(rentalPriceController.text),
                  availableForRent: availableForRent,
                  availableForSale: availableForSale,
                  images: context.read<AddMediaCubit>().imageFiles,
                  videos: context.read<AddMediaCubit>().videoFiles,
                );
                context.read<AddProductCubit>().addProduct(productUploadModel);
              }
            },
            label: const Text("Add Product"),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField(nameEnController, "Name (EN)"),
      _buildTextField(nameArController, "Name (AR)"),
      _buildTextField(categoryEnController, "Category (EN)"),
      _buildTextField(companyEnController, "Company (EN)"),
      _buildTextField(descEnController, "Description (EN)", maxLines: 2),
      _buildTextField(rentStockController, "Rent Stock", isNumber: true),
      _buildTextField(saleStockController, "Sale Stock", isNumber: true),
      _buildTextField(salePriceController, "Sale Price", isNumber: true),
      _buildTextField(rentalPriceController, "Rental Price", isNumber: true),
    ];
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

  Widget _buildAvailabilityCheckboxes() {
    return Row(
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
    );
  }
}
