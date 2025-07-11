import 'package:blog_app/core/common/app_user/app_User_cubit.dart';
import 'package:blog_app/core/network/Connection_checker.dart';
import 'package:blog_app/feacher/authentication/data/dataSources/Auth_Remote_Data_Source.dart';
import 'package:blog_app/feacher/authentication/data/repository/Auth_Repository_impl.dart';
import 'package:blog_app/feacher/authentication/domain/repository/AuthRepository.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/Current_User.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/User_Login.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/User_Sing_Up.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/AuthBloc.dart';
import 'package:blog_app/feacher/blog/Data/DataSources/Blog_Local_DataSource.dart';
import 'package:blog_app/feacher/blog/Data/DataSources/Blog_Remote_data_Sourse.dart';
import 'package:blog_app/feacher/blog/Data/Repositorys/Blog_Repository_Imp.dart';
import 'package:blog_app/feacher/blog/Domain/Repositorys/Blog_Respository.dart';
import 'package:blog_app/feacher/blog/Domain/useCases/Upload_Blog.dart';
import 'package:blog_app/feacher/blog/Domain/useCases/get_all_Blog.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogBloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/sectects/SupabaseSecrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies()  async{
  _initAuth();
  final superbase = await Supabase.initialize(
      url: SupabaseSecrets.url,
      anonKey: SupabaseSecrets.anon_key
  );
  serviceLocator.registerLazySingleton(() => superbase.client,);
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'),);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
}

void _initAuth(){


  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit(),);

  serviceLocator.registerFactory(() => UserSingUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  //Connection
  serviceLocator.registerLazySingleton(() => InternetConnection(),);
  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImp(serviceLocator() ),);

  //Bloc
  serviceLocator.registerFactory(() => BlogBloc(
      uploadBlog: serviceLocator(),
    getAllBlogs: serviceLocator()
  ),);

  //local
  serviceLocator.registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(serviceLocator()),);

  serviceLocator.registerFactory(() => UploadBlog(blogRepository: serviceLocator()),);
  serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImp(serviceLocator() ,serviceLocator() ,serviceLocator()),);
  serviceLocator.registerFactory<BlogRemoteDataSource>(() => BlogRemotedataSourceImpl(serviceLocator()),);
  serviceLocator.registerFactory(() => GetAllBlogs(serviceLocator()),);

  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator() , serviceLocator()));
  serviceLocator.registerFactory<AuthBloc>(
        () => AuthBloc(
            userSingUp: serviceLocator(),
            userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator()
        ),);


}