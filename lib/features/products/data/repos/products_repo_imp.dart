import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/products/data/models/product_edit_model.dart';
import 'package:med_tech_admin/features/products/data/models/product_model.dart';
import 'package:med_tech_admin/features/products/data/models/product_upload_model.dart';
import 'package:med_tech_admin/features/products/domain/entities/product_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repos/products_repo.dart';

class ProductsRepoImp implements ProductsRepo {
  final DatabaseService databaseService;

  ProductsRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> addProduct(ProductUploadModel product) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.addProduct,
        data: await product.toFormData(),
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
      log(e.toString());
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
        quary: {"withVideos": true},
      );

      List<ProductEntity> products = List<ProductEntity>.from(
        data["products"].map((e) => ProductModel.fromJson(e).toEntity()),
      );

      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // في ملف products_repo_imp.dart
  @override
  Future<Either<Failure, void>> editProduct(String id, ProductEditeModel product) async {
    try {
      await databaseService.updateDataa(
        endpoint: '${BackendEndpoints.updateProduct}/$id',
        data: await product.toFormData(isEdit: true),
      );

      return right(null); // لم نصل إلى هنا
    } catch (e) {
      log('--- EDIT PRODUCT API FAILED ---');
      log('Error: $e');
      if (e is DioException) {
        log('Dio Error Response Data: ${e.response?.data}');
      }
      // 👈 تم التقاط الخطأ هنا
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e)); // على الأغلب هذا ما حدث
      }
      return left(ServerFailure(errMessage: e.toString())); // أو هذا
    }
  }

}
