

import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:blog_app/feacher/blog/Domain/Repositorys/Blog_Respository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogs implements UseCase<List<Blog> , NoPeram>{
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failures, List<Blog>>> call(NoPeram perm) async{
    return  await blogRepository.getAllBlog();
  }

}
