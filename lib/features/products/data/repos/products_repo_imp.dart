import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/products/data/models/product_model.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repos/products_repo.dart';

class ProductsRepoImp implements ProductsRepo {
  final DatabaseService databaseService;

  ProductsRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, String>> addProduct(ProductModel product) async {
    try {
      dynamic data = await databaseService.addData(
        endpoint: BackendEndpoints.products,
        data: product.toJson(),
      );
      return right("right");
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    try {
      dynamic data = await databaseService.deleteData(
        endpoint: BackendEndpoints.products,
        rowid: id,
      );
      return right("right");
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateProduct(
    String id,
    ProductModel product,
  ) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
