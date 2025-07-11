

import 'dart:io';

sealed class BlogEvent{}

class BlogUpload  extends BlogEvent{
  final String posterid;
  final String titile;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({required this.posterid, required this.titile, required this.content, required this.image, required this.topics});
}

 class BlogFetchAllBlogs extends BlogEvent{}