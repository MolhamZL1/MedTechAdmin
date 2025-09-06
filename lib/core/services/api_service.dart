import 'package:dio/dio.dart';

import '../utils/backend_endpoints.dart';
import 'database_service.dart';

class ApiService implements DatabaseService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: BackendEndpoints.url,
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJlc3JhYXNoYW1tb3V0Nzg4QGdtYWlsLmNvbSIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc1NjkyNDg5OSwiZXhwIjoxNzg4NDYwODk5fQ.pQiXmnIk_gMDqwgvQ77gZvih8BQyEeQkSJsycOHbRPE",
      },
    ),
  );

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
