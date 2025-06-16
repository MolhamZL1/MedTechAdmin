import 'package:get_it/get_it.dart';
import 'package:med_tech_admin/core/services/api_service.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/features/auth/data/repos/auth_repo_imp.dart';

import '../../features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupSingltonGetIt() {
  getIt.registerSingleton<DatabaseService>(ApiService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}
