import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/screens/app_splash/app_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bloc/detail_bloc.dart';
import 'bloc/users_bloc.dart';
import 'data/dio_settings.dart';
import 'data/user_repo.dart';
import 'screens/main_screen/widget/main_vm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InitialWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        home: const AppSplash(),
      ),
    );
  }
}

// ignore: must_be_immutable
class InitialWidget extends StatelessWidget {
  InitialWidget({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: ((context) => DioSettings())),
        RepositoryProvider(
          create: (context) => UserRepo(dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                UsersBloc(repo: RepositoryProvider.of<UserRepo>(context))
                  ..add(GetUsersEvent(name: '', page: 1)),
          ),
          BlocProvider(
            create: (context) =>
                DetailBloc(repo: RepositoryProvider.of<UserRepo>(context))
                  ..add(GetDetailEvent(id: '1')),
          ),
        ],
        child: ChangeNotifierProvider(create: (BuildContext context) => MainVm(), child: child),
      ),
    );
  }
}
