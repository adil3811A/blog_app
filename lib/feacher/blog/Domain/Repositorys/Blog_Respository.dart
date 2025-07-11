

import 'dart:io';

import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository{
  Future<Either<Failures , Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic,
});

  Future<Either<Failures , List<Blog>>> getAllBlog();
}


