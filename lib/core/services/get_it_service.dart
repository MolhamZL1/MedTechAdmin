import 'package:get_it/get_it.dart';
import 'package:med_tech_admin/features/orders/data/repos/order_repo_imp.dart';
import 'package:med_tech_admin/features/orders/domain/repos/order_repo.dart';
import 'package:med_tech_admin/features/products/data/repos/products_repo_imp.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/settings/data/repos/settings_repo_imp.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:med_tech_admin/features/users/domain/repos/user_repo.dart';

import '../../features/Financial/data/repo/financial_repo_imp.dart';
import '../../features/Financial/domain/repo/financial_repo.dart';
import '../../features/ai chat/data/repo/ai_chat_repo_imp.dart';
import '../../features/ai chat/domain/repos/ai_chat_repo.dart';
import '../../features/auth/data/repos/auth_repo_imp.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/dashboard/data/repos/offer_repo_imp.dart';
import '../../features/dashboard/domain/repos/offer_repo.dart';
import '../../features/users/data/repos/user_repo_imp.dart';
import '../functions/getLocalUser.dart';
import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;
void setupSingltonGetIt() async {
  getIt.registerLazySingleton<UserService>(() => UserService());

  getIt.registerSingleton<DatabaseService>(ApiService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );

  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<UserRepo>(
    UserRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<SettingsRepo>(
    SettingsRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<OrderRepo>(
    OrderRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AiChatRepo>(
    AiChatRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<EarningsReportRepo>(
    EarningsReportRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<AdvertisementRepo>(
    AdvertisementRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
}