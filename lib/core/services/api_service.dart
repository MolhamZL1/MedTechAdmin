import 'package:dio/dio.dart';

import 'database_service.dart';

class ApiService implements DatabaseService {
  final Dio dio;

  ApiService({required this.dio});
  @override
  Future<Response> addData({
    required String endpoint,
    required Map<String, dynamic> data,
    String? rowid,
  }) async {
    if (rowid != null) {
      return await dio.post(endpoint + rowid, data: data);
    } else {
      return await dio.post(endpoint, data: data);
    }
  }

  @override
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  }) async {
    Response response;
    if (rowid != null) {
      response = await dio.get(endpoint + rowid, queryParameters: quary);
    }
    else {
      response = await dio.get(endpoint, queryParameters: quary);
      // Response response = await dio.get(endpoint + rowid);
      // return response.data;
    }
    // else {
    //   Response response = await dio.get(endpoint);
    //   return response.data;
    // }
    return response.data;
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
}
