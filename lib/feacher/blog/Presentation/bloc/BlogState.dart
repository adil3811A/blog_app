

import '../../Domain/Entity/Blog.dart';

sealed  class  BlogState{}

final class BlogInit extends BlogState{}
final class BlogLoading extends BlogState{}
final class BlogFailure extends BlogState{
  final String message;

  BlogFailure(this.message);
}
final class BlogUploadSuccess extends BlogState{
  final Blog blog;

  BlogUploadSuccess(this.blog);
}
final class BlogDisplaySuccessBlog extends BlogState{
  final List<Blog> blogs;

  BlogDisplaySuccessBlog(this.blogs);
}