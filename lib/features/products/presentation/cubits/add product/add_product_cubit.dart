import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/products/data/models/product_upload_model.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_edit_model.dart';
import '../../../data/models/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.productsRepo) : super(AddProductInitial());
  final ProductsRepo productsRepo;

  Future<void> addProduct(ProductUploadModel product) async {
    emit(AddProductLoading());
    final failureOrProducts = await productsRepo.addProduct(product);
    failureOrProducts.fold(
      (failure) {
        emit(AddProductError(failure.errMessage));
      },
      (products) {
        emit(AddProductSuccess());
      },
    );
  }
  Future<void> editProduct(String id, ProductEditeModel product) async {
    emit(AddProductLoading()); // يمكن استخدام نفس حالة التحميل
    final failureOrSuccess = await productsRepo.editProduct(id, product);
    failureOrSuccess.fold(
          (failure) {
        emit(AddProductError(failure.errMessage));
      },
          (_) {
        emit(AddProductSuccess()); // يمكن استخدام نفس حالة النجاح
      },
    );
  }

}
