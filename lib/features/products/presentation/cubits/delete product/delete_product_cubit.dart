import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:meta/meta.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit(this.productsRepo) : super(DeleteProductInitial());

  final ProductsRepo productsRepo;

  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoading());
    final failureOrProducts = await productsRepo.deleteProduct(id);
    failureOrProducts.fold(
      (failure) {
        emit(DeleteProductError(failure.errMessage));
      },
      (products) {
        emit(DeleteProductSuccess());
      },
    );
  }
}
