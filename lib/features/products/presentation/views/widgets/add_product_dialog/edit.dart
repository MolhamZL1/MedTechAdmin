import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/products/data/models/product_upload_model.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/cubit/add_media_cubit.dart';

import '../../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../../core/widgets/showsuccessDialog.dart';
import '../../../../data/models/product_edit_model.dart';
import 'MediaUploadSection.dart'; // تأكد من صحة هذا المسار

class ProductEditDialog extends StatefulWidget {
  final ProductEntity product;
  const ProductEditDialog({super.key, required this.product});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameEnController;
  late TextEditingController nameArController;
  late TextEditingController categoryEnController;
  late TextEditingController categoryArController;
  late TextEditingController companyEnController;
  late TextEditingController companyArController;
  late TextEditingController descEnController;
  late TextEditingController descArController;
  late TextEditingController rentStockController;
  late TextEditingController saleStockController;
  late TextEditingController salePriceController;
  late TextEditingController costPriceController;
  late TextEditingController rentalPriceController;

  late bool availableForRent;
  late bool availableForSale;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    nameEnController = TextEditingController(text: p.nameEn);
    nameArController = TextEditingController(text: p.nameAr);
    categoryEnController = TextEditingController(text: p.categoryEn);
    categoryArController = TextEditingController(text: p.categoryAr);
    companyEnController = TextEditingController(text: p.companyEn);
    companyArController = TextEditingController(text: p.companyAr);
    descEnController = TextEditingController(text: p.descriptionEn);
    descArController = TextEditingController(text: p.descriptionAr);
    rentStockController = TextEditingController(text: p.rentStock.toString());
    saleStockController = TextEditingController(text: p.saleStock.toString());
    salePriceController = TextEditingController(text: p.salePrice.toString());
  //  costPriceController = TextEditingController(text: p.costPrice.toString());
    rentalPriceController = TextEditingController(text: p.rentalPrice.toString());

    availableForRent = p.availableForRent;
    availableForSale = p.availableForSale;

    // ملاحظة: لا يمكن تعديل الصور والفيديوهات الحالية هنا، فقط إضافة جديد
    // يمكنك مسح الوسائط القديمة عند البدء إذا أردت
    context.read<AddMediaCubit>().clearMedia();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16), right: Radius.circular(16)),
      ),
      title: const Text(
        "Edit Product", // تغيير العنوان
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
                      title: "Upload New Images (Optional)",
                      files: context.watch<AddMediaCubit>().imageFiles,
                      onUpload: context.read<AddMediaCubit>().addImage,
                      onDelete: context.read<AddMediaCubit>().removeImage,
                      isImage: true,
                    ),
                    MediaUploadSection(
                      title: "Upload New Videos (Optional)",
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
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );
            }
            else if (state is AddProductError) {
              Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading
              showerrorDialog(
                context: context,
                title: "Error",
                // ✨✨ هذه هي الرسالة التي تأتي من الخادم ✨✨
                description: state.errMessage,
              );
            }
            else if (state is AddProductError) {
              Navigator.of(context, rootNavigator: true).pop();
              showerrorDialog(
                context: context,
                title: "Error",
                description: state.errMessage,
              );
            } else if (state is AddProductSuccess) {
              Navigator.of(context).pop();
              showsuccessDialog(
                context: context,
                title: "Success",
                description: "Product Updated Successfully\nRefresh Page Please",
                btnOkOnPress: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              );
            }
          },
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              // لا نستخدم validator هنا لأن بعض الحقول قد تكون فارغة عمدًا
              // if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final productUploadModel = ProductEditeModel(
                nameEn: nameEnController.text,
                nameAr: nameArController.text,
                categoryEn: categoryEnController.text,
                categoryAr: categoryArController.text,
                companyEn: companyEnController.text,
                companyAr: companyArController.text,
                descriptionEn: descEnController.text,
                descriptionAr: descArController.text,
                rentStock: int.tryParse(rentStockController.text),
                saleStock: int.tryParse(saleStockController.text),
                salePrice: double.tryParse(salePriceController.text),
                rentalPrice: double.tryParse(rentalPriceController.text),
                availableForRent: availableForRent,
                availableForSale: availableForSale,
               // costPrice: double.tryParse(costPriceController.text),
                images: context.read<AddMediaCubit>().imageFiles,
                videos: context.read<AddMediaCubit>().videoFiles,
              );
              // استدعاء دالة التعديل
              context.read<AddProductCubit>().editProduct(widget.product.id.toString(), productUploadModel);
              // }
            },
            label: const Text("Save Changes"), // تغيير النص
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
      _buildTextField(categoryArController, "Category (AR)"),
      _buildTextField(companyEnController, "Company (EN)"),
      _buildTextField(companyArController, "Company (AR)"),
      _buildTextField(descEnController, "Description (EN)", maxLines: 2),
      _buildTextField(descArController, "Description (AR)", maxLines: 2),
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
        // في التعديل، لا نجبر المستخدم على ملء كل الحقول
        // validator: (value) => value == null || value.isEmpty ? "Required" : null,
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
