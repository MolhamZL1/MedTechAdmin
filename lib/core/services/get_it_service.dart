import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';

import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;

void setupSingltonGetIt() {
  getIt.registerSingleton<DatabaseService>(
    ApiService(dio: Dio(BaseOptions(baseUrl: BackendEndpoints.url))),
  );

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}
