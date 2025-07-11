import 'dart:io';

import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:blog_app/feacher/blog/Domain/Repositorys/Blog_Respository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/userCase/useCase.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParam>{
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParam perm) async{
    return await blogRepository.uploadBlog(image: perm.image, title: perm.titile, content: perm.content, posterId:
        perm.posterid, topic: perm.topics);
  }



}

class UploadBlogParam{
  final String posterid;
  final String titile;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParam({required this.posterid, required this.titile, required this.content, required this.image, required this.topics});
}