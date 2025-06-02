abstract class DatabaseService {
  Future<void> addData(
      {required String endpoint,
      required Map<String, dynamic> data,
      String? rowid});
  Future<dynamic> getData(
      {required String endpoint, String? rowid, Map<String, dynamic>? quary});
  Future<bool> checkData({required String endpoint, String? rowid});
}
