import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/getLocalUser.dart';
import 'package:med_tech_admin/core/functions/on_generate_route.dart';
import 'package:med_tech_admin/core/services/custom_bloc_observer.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/App_themes.dart';
import 'package:med_tech_admin/features/ai%20chat/domain/repos/ai_chat_repo.dart';
import 'package:med_tech_admin/features/ai%20chat/presentation/cubits/send%20ai%20message/send_ai_message_cubit.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:med_tech_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:med_tech_admin/features/main/presentation/views/main_view.dart';
import 'package:med_tech_admin/features/orders/domain/repos/order_repo.dart';
import 'package:med_tech_admin/features/orders/presentation/views/cubits/cubit.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/settings/presentation/cubits/theme/theme_cubit.dart';
import 'package:med_tech_admin/features/users/domain/repos/user_repo.dart';
import 'package:med_tech_admin/features/users/presentation/cubits/user_cubit.dart';

import 'features/Financial/domain/repo/financial_repo.dart';
import 'features/Financial/presentaion/cubits/cubit.dart';
import 'features/ai chat/presentation/cubits/get ai messages cubit/get_ai_messages_cubit.dart';
import 'features/auth/domain/repos/auth_repo.dart';
import 'features/dashboard/domain/repos/offer_repo.dart';
import 'features/dashboard/presentation/cubits/cubit.dart';
import 'features/main/presentation/cubits/cubit/sidebar_cubit_cubit.dart';
import 'features/products/domain/repos/products_repo.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  setupSingltonGetIt();
  await getIt<UserService>().loadUser();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepo>())),
        BlocProvider(create: (context)=> UserCubit(getIt.get<UserRepo>())),
        BlocProvider(create: (context)=> AddProductCubit(getIt.get<ProductsRepo>())),

        BlocProvider(create: (context)=>SendAiMessageCubit(getIt.get<AiChatRepo>())),
        BlocProvider(create: (context)=>GetAiMessagesCubit(getIt.get<AiChatRepo>())),
        BlocProvider(create: (context) => OrderCubit(getIt.get<OrderRepo>())),
        BlocProvider(create: (context) => SidebarCubit()),
        BlocProvider(create: (context) => EarningsReportCubit(getIt.get<EarningsReportRepo>())),
        BlocProvider(create: (context) => AdvertisementCubit(getIt.get<AdvertisementRepo>())),

      ],
      child: const MedTech(),
    ),
  );
}

class MedTech extends StatelessWidget {
  const MedTech({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(

      builder: (context, thememode) {
        return MaterialApp(
          title: "BitarMed",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: thememode,
          onGenerateRoute: (settings) => onGenerateRoute(settings),
          //  initialRoute: SignInView.routeName,
          debugShowCheckedModeBanner: false,
          home: SelectableRegion(
            focusNode: FocusNode(),
            selectionControls: materialTextSelectionControls,
            child: const StartScreen(),
          ),
        );
      },
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<UserService>().user;

    return (user != null && user.token.isNotEmpty)
        ? const MainView()
        : const SignInView();
  }
}
