import 'package:blog_app/core/Utils/Calculate_Reading_TIme.dart';
import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';
import 'package:blog_app/feacher/blog/Presentation/page/Blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {

  final Blog blog;
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.all(16).copyWith(bottom: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                  blog.topics.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Chip(
                          label: Text(e),
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
            Expanded(
              child: Text(
                  blog.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('${calCulateReadingTime(blog.content)} mint')
          ],
        ),
      ),
    );
  }
}
