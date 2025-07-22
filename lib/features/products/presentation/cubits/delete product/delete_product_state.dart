part of 'delete_product_cubit.dart';

@immutable
sealed class DeleteProductState {}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductError extends DeleteProductState {
  final String errMessage;
  DeleteProductError(this.errMessage);
}

final class DeleteProductSuccess extends DeleteProductState {}
