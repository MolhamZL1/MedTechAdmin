import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/widgets/show_err_dialog.dart';
import 'package:med_tech_admin/core/widgets/showsuccessDialog.dart';
import 'package:med_tech_admin/features/products/data/models/product_model.dart'; // ✅ استيراد ProductModel
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';

class ProductEditDialog extends StatefulWidget {
  final ProductEntity product;
  const ProductEditDialog({super.key, required this.product});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  final _formKey = GlobalKey<FormState>();

  // 1. تعريف الـ Controllers
  late TextEditingController nameEnController;
  late TextEditingController nameArController;
  late TextEditingController categoryEnController;
  late TextEditingController companyEnController;
  late TextEditingController descEnController;
  late TextEditingController rentStockController;
  late TextEditingController saleStockController;
  late TextEditingController salePriceController;
  late TextEditingController rentalPriceController;
  late TextEditingController costPriceController;

  late bool availableForRent;
  late bool availableForSale;

  @override
  void initState() {
    super.initState();
    // 2. ملء الـ Controllers بالبيانات الحالية للمنتج
    final product = widget.product;
    nameEnController = TextEditingController(text: product.nameEn);
    nameArController = TextEditingController(text: product.nameAr);
    categoryEnController = TextEditingController(text: product.categoryEn);
    companyEnController = TextEditingController(text: product.companyEn);
    descEnController = TextEditingController(text: product.descriptionEn);
    rentStockController = TextEditingController(text: product.rentStock.toString());
    saleStockController = TextEditingController(text: product.saleStock.toString());
    salePriceController = TextEditingController(text: product.salePrice.toString());
    rentalPriceController = TextEditingController(text: product.rentalPrice.toString());
    costPriceController = TextEditingController(text: product.costPrice.toString());
    availableForRent = product.availableForRent;
    availableForSale = product.availableForSale;
  }

  @override
  void dispose() {
    // 3. التخلص من كل الـ Controllers
    nameEnController.dispose();
    nameArController.dispose();
    categoryEnController.dispose();
    companyEnController.dispose();
    descEnController.dispose();
    rentStockController.dispose();
    saleStockController.dispose();
    salePriceController.dispose();
    rentalPriceController.dispose();
    costPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Edit Product: ${widget.product.nameEn}",
        style: const TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
        width: 800, // نفس عرض ديالوغ الإضافة
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ..._buildTextFields(),
                _buildAvailabilityCheckboxes(),
                // تم حذف قسم رفع الوسائط لأنه غير مدعوم في Cubit التعديل الحالي
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
        BlocListener<AddProductCubit, AddProductState>(
          listener: (context, state) {
            if (state is AddProductError) {
              Navigator.of(context).pop(); // إغلاق ديالوغ التعديل
              showerrorDialog(
                context: context,
                title: "Error",
                description: state.errMessage,
              );
            } else if (state is AddProductSuccess) {
              Navigator.of(context).pop(); // إغلاق ديالوغ التعديل
              showsuccessDialog(
                context: context,
                title: "Success",
                description: "Product updated successfully.",
              );
            }
          },
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save), // تغيير الأيقونة
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // ✅ 4. إنشاء ProductModel بالبيانات المحدثة
                final updatedProduct = ProductModel(
                  id: widget.product.id, // استخدام الـ ID الأصلي
                  nameEn: nameEnController.text,
                  nameAr: nameArController.text,
                  categoryEn: categoryEnController.text,
                  categoryAr: widget.product.categoryAr, // استخدام القيمة الأصلية
                  companyEn: companyEnController.text,
                  companyAr: widget.product.companyAr, // استخدام القيمة الأصلية
                  descriptionEn: descEnController.text,
                  descriptionAr: widget.product.descriptionAr, // استخدام القيمة الأصلية
                  rentStock: int.parse(rentStockController.text),
                  saleStock: int.parse(saleStockController.text),
                  salePrice: double.parse(salePriceController.text),
                  rentalPrice: double.parse(rentalPriceController.text),
                  costPrice: double.parse(costPriceController.text),
                  availableForRent: availableForRent,
                  availableForSale: availableForSale,
                  imagesUrl: [], // قائمة فارغة لأننا لا نعدل الوسائط
                  videos: [],
                  qrCode: '',
                  rate:int.parse(saleStockController.text),// قائمة فارغة
                );

                // ✅ 5. استدعاء دالة التحديث من الـ Cubit
                context.read<AddProductCubit>().updateProduct(
                  widget.product.id.toString(),
                  updatedProduct,
                );
              }
            },
            label: const Text("Save Changes"), // تغيير النص
          ),
        ),
      ],
    );
  }

  // ✅ نفس دوال بناء الحقول الموجودة في ديالوغ الإضافة
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
      _buildTextField(costPriceController, "Cost Price", isNumber: true),
    ];
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        bool isNumber = false,
        int maxLines = 1,
      }) {
    return SizedBox(
      width: 350, // نفس العرض
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : null,
        decoration: InputDecoration(labelText: label),
        // ✅ جعل التحقق من الصحة إجباريًا للحفاظ على نفس سلوك الإضافة
        validator: (value) => value == null || value.isEmpty ? "Required" : null,
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
