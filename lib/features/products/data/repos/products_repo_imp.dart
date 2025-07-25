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
  Future<Either<Failure, void>> addProduct(ProductModel product) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.addProduct,
        data: product.toJson(),
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await databaseService.deleteData(
        endpoint: BackendEndpoints.deleteProduct,
        rowid: id,
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var data = await databaseService.getData(
        endpoint: BackendEndpoints.getProducts,
      );
      List<ProductEntity> products = List<ProductEntity>.from(
        data.map((e) => ProductModel.fromJson(e).toEntity()),
      );
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(
    String id,
    ProductModel product,
  ) async {
    try {
      await databaseService.updateData(
        endpoint: BackendEndpoints.updateProduct,
        rowid: id,
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
