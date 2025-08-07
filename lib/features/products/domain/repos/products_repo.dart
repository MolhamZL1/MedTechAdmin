import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/features/products/data/models/product_upload_model.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, void>> addProduct(ProductUploadModel product);
  Future<Either<Failure, void>> updateProduct(String id, ProductModel product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
