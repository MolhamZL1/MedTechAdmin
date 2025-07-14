import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, String>> addProduct(ProductModel product);
  Future<Either<Failure, String>> updateProduct(
    String id,
    ProductModel product,
  );
  Future<Either<Failure, String>> deleteProduct(String id);
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, String>> getCategories();
}
