import 'package:blog_app/core/Utils/Calculate_Reading_TIme.dart';
import 'package:blog_app/core/Utils/Format_Date.dart';
import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {

  final Blog blog;

  static route(Blog blog) => MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog,),);

  const BlogViewerPage({super.key , required  this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  blog.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),
              ),
              SizedBox(height: 20,),
              Text(
                  'By ${blog.posterName}',
                style: TextStyle(
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 5,),
              Text(
                  '${formatDateBydMMYYYY(blog.updatedAt)} . ${calCulateReadingTime(blog.content)} mint',
                style: TextStyle(
                  color: AppPallete.greyColor,
                  fontSize: 16
                ),
              ),
              SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.network(
                    blog.imageUrl,
                ),
              ),
              Text(
                  blog.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 2
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
