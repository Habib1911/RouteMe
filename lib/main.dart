import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mobile/business_logic/add_branch_cubit/add_branch_cubit.dart';
import 'package:mobile/business_logic/app_cubit/app_cubit.dart';
import 'package:mobile/business_logic/app_cubit/app_state.dart';
import 'package:mobile/business_logic/bloc_observer.dart';
import 'package:mobile/business_logic/branches_cubit/branches_cubit.dart';
import 'package:mobile/business_logic/driver_tasks_cubit/driver_tasks_cubit.dart';
import 'package:mobile/business_logic/finish_task_cubit/finish_task_cubit.dart';
import 'package:mobile/business_logic/language_cubit/language_cubit.dart';
import 'package:mobile/business_logic/login_cubit/login_cubit.dart';
import 'package:mobile/business_logic/pickup_cubit/pickup_cubit.dart';
import 'package:mobile/business_logic/previous_tasks_cubit/previous_tasks_cubit.dart';
import 'package:mobile/business_logic/reset_password_cubit/reset_password_cubit.dart';
import 'package:mobile/business_logic/verify_cubit/verify_cubit.dart';
import 'package:mobile/data/remote/dio_helper.dart';
import 'package:mobile/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';
import 'business_logic/order_cubit/order_cubit.dart';
import 'data/local/cache_helper.dart';
import 'presentation/router/app_router.dart';
import 'presentation/styles/colors.dart';

late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();
      final locale =
          CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar";
      delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        showToast(e.toString());
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AppCubit()..permission),
        ),
        BlocProvider(
          create: ((context) => LoginCubit()),
        ),
        BlocProvider(
          create: ((context) => VerifyCubit()),
        ),
        BlocProvider(
          create: ((context) => ResetPasswordCubit()),
        ),
        BlocProvider(
          create: ((context) => LanguageCubit()),
        ),
        BlocProvider(
          create: ((context) => AddBranchCubit()),
        ),
        BlocProvider(
          create: ((context) => PickupCubit()..myBranches),
        ),
        BlocProvider(
          create: ((context) => BranchesCubit()..myBranches),
        ),
        BlocProvider(
          create: ((context) => OrderCubit()..myOrders),
        ),
        BlocProvider(
          create: ((context) => DriverTasksCubit()..myTasks),
        ),
        BlocProvider(
          create: ((context) => PreviousTasksCubit()..myTasks),
        ),
        BlocProvider(
          create: ((context) => FinishTaskCubit()),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LocalizedApp(
                delegate,
                LayoutBuilder(builder: (context, constraints) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Route Me',
                    localizationsDelegates: [
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,  
                      GlobalWidgetsLocalizations.delegate,
                      delegate,
                    ],
                    locale: delegate.currentLocale,
                    supportedLocales: delegate.supportedLocales,
                    onGenerateRoute: widget.appRouter.onGenerateRoute,
                    theme: ThemeData(
                      fontFamily: 'cairo',
                      scaffoldBackgroundColor: AppColors.white,
                      appBarTheme: const AppBarTheme(
                        elevation: 0.0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: AppColors.transparent,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          );
        }, 
      ),
    );
  }
}
