import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/products/data/repos/products_repo_imp.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/settings/data/repos/settings_repo_imp.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:med_tech_admin/features/users/Data/repos/user_repo_imp.dart';

import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../functions/getLocalUser.dart';
import 'api_service.dart';
import 'database_service.dart';
import '../../features/users/domain/repos/user_repo.dart';


final getIt = GetIt.instance;
Future<void> setupSingltonGetIt() async {
  String? token = await getLocalUser().then((value) => value?.token.toString());

  print('Loaded token: $token');

  getIt.registerSingleton<DatabaseService>(
    ApiService(
      dio: Dio(
        BaseOptions(
          baseUrl: BackendEndpoints.url,
          headers: {
            "Authorization": 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJlc3JhYXNoYW1tb3V0Nzg4QGdtYWlsLmNvbSIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc1NDU1OTQ3NSwiZXhwIjoxNzU1MTY0Mjc1fQ.yHnVViBxIrf4WDM5MjP5yhSXf5Pv5sIO9K7QHk74HKU'
          },
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

  getIt.registerSingleton<UserRepo>(
    UserRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}

