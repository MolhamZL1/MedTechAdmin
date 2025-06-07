abstract class DatabaseService {
  Future<dynamic> addData({
    required String endpoint,
    required Map<String, dynamic> data,
    String? rowid,
  });
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  });
}
