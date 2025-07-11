import 'package:blog_app/core/common/app_user/app_User_cubit.dart';
import 'package:blog_app/core/common/app_user/app_user_cubut_state.dart';
import 'package:blog_app/core/theme/app_theam.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/AuthBloc.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_Events.dart';
import 'package:blog_app/feacher/authentication/presentation/pages/login_page.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogBloc.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feacher/Blog/Presentation/page/Blog_Page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AuthBloc>(),),
      BlocProvider(create: (context) => serviceLocator<AppUserCubit>(),),
      BlocProvider(create: (context) => serviceLocator<BlogBloc>(),),
    ],
      child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.


  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLogin());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:AppTheme.appTheme,
      home: BlocSelector<AppUserCubit , AppUserCubitState , bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
          builder: (BuildContext context, bool isLoggedin) {
            if(isLoggedin){
              return BlogPage();
            }else{
              return LoginPage();
            }
          },
      ),
    );
  }
}

