import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/product_entity.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this.productsRepo) : super(GetProductsInitial()) {
    getProducts();
  }
  final ProductsRepo productsRepo;

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final failureOrProducts = await productsRepo.getProducts();
    failureOrProducts.fold(
      (failure) {
        emit(GetProductsError(failure.errMessage));
      },
      (products) {
        emit(GetProductsSuccess(products));
      },
    );
  }
}
