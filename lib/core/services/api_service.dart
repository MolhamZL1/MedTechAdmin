import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/backend_endpoints.dart';
import 'database_service.dart';

class ApiService implements DatabaseService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: BackendEndpoints.url,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ) {
    // يحقن التوكن قبل كل طلب
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          // ما نضيف الهيدر لطلبات الأثنتيكেশন (اختياري)
          final p = options.path;
          final isAuthCall =
              p.contains('/auth/login') ||
              p.contains('/auth/register') ||
              p.contains('/auth/refresh');

          if (!isAuthCall &&
              token != null &&
              token.isNotEmpty &&
              options.headers['Authorization'] == null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<dynamic> addData({
    required String endpoint,
    required dynamic data,
    String? rowid,
  }) async {
    if (rowid != null) {
      Response response = await dio.post(endpoint + rowid, data: data);
      return response.data;
    } else {
      Response response = await dio.post(endpoint, data: data);
      return response.data;
    }
  }

  @override
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  }) async {
    if (rowid != null) {
      Response response = await dio.get(
        endpoint + rowid,
        queryParameters: quary,
      );
      return response.data;
    } else {
      Response response = await dio.get(endpoint, queryParameters: quary);
      return response.data;
    }
  }

  @override
  Future deleteData({required String endpoint, String? rowid}) async {
    if (rowid == null) {
      return await dio.delete(endpoint);
    }
    return await dio.delete(endpoint + rowid);
  }

  @override
  Future updateData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(endpoint + (rowid ?? ""), data: data);
  }

  @override
  Future patchData({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    Response response = await dio.patch(endpoint, data: data);
    return response.data;
  }
}
