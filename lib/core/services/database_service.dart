abstract class DatabaseService {
  Future addData({
    required String endpoint,
    required Map<String, dynamic> data,
    String? rowid,
  });
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  });
  Future<dynamic> deleteData({required String endpoint, String? rowid});
  Future<dynamic> updateData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? data,
  });
}
