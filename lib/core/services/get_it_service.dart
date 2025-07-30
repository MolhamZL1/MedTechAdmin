import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/products/data/repos/products_repo_imp.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/settings/data/repos/settings_repo_imp.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';

import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../functions/getLocalUser.dart';
import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;
void setupSingltonGetIt() async {
  getIt.registerLazySingleton<UserService>(() => UserService());

  getIt.registerSingleton<DatabaseService>(
    ApiService(
      dio: Dio(
        BaseOptions(
          baseUrl: BackendEndpoints.url,
          headers:
              getIt<UserService>().user?.token != null
                  ? {
                    "Authorization":
                        "Bearer ${getIt<UserService>().user?.token}",
                  }
                  : null,
        ),
      ),
    ),
  );

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );

  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<SettingsRepo>(
    SettingsRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}
