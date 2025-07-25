import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.productsRepo) : super(AddProductInitial());
  final ProductsRepo productsRepo;

  Future<void> addProduct(ProductModel product) async {
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

  Future<void> updateProduct(String id, ProductModel product) async {
    emit(AddProductLoading());
    final failureOrProducts = await productsRepo.updateProduct(id, product);
    failureOrProducts.fold(
      (failure) {
        emit(AddProductError(failure.errMessage));
      },
      (products) {
        emit(AddProductSuccess());
      },
    );
  }
}
