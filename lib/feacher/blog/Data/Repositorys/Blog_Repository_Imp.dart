

import 'dart:io';

import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/error/ServerException.dart';
import 'package:blog_app/core/network/Connection_checker.dart';
import 'package:blog_app/feacher/blog/Data/DataSources/Blog_Local_DataSource.dart';
import 'package:blog_app/feacher/blog/Data/DataSources/Blog_Remote_data_Sourse.dart';
import 'package:blog_app/feacher/blog/Data/model/Blog_Model.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:blog_app/feacher/blog/Domain/Repositorys/Blog_Respository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository{

  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImp(this.blogRemoteDataSource, this.blogLocalDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String>
  topic}) async{
    try{
      if(!await (connectionChecker.isConnected)){
        return left(Failures('No Internet connection'));
      }
      BlogModel blogModel= BlogModel(
          id: Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topic,
          updatedAt: DateTime.now()
      );
      final imageurl  =await blogRemoteDataSource.uploadBlogImage(file: image , blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageurl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blog: blogModel);
      return right(uploadedBlog);
    }on ServerExeception catch(e){
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getAllBlog() async{
    try{
      if(!await (connectionChecker.isConnected)){
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final result = await blogRemoteDataSource.getAllBlogs();
      // if(result.isNotEmpty){
      //   blogLocalDataSource.uploadLocalBlogs(blogs: result);
      // }
      return right(result);
    }on ServerExeception catch(e){
      return  left(Failures(e.message));
    }
  }
}