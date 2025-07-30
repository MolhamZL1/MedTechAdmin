import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/getLocalUser.dart';
import 'package:med_tech_admin/core/functions/on_generate_route.dart';
import 'package:med_tech_admin/core/services/custom_bloc_observer.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/App_themes.dart';
import 'package:med_tech_admin/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:med_tech_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:med_tech_admin/features/main/presentation/views/main_view.dart';
import 'package:med_tech_admin/features/settings/presentation/cubits/theme/theme_cubit.dart';

import 'features/auth/domain/repos/auth_repo.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  setupSingltonGetIt();

  await getIt<UserService>().loadUser();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepo>())),
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
