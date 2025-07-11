
import 'package:blog_app/core/common/widgets/Loader.dart';
import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogBloc.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogEvents.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogState.dart';
import 'package:blog_app/feacher/blog/Presentation/wiget/Blog_Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Add_New_Blog_Page.dart' show AddNewBlogPage;




class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("blog app"),
        actions: [
           IconButton(onPressed: () {
             Navigator.push(context, AddNewBlogPage.route());
          }, icon: Icon(CupertinoIcons.add))
        ],
      ),
      body: BlocConsumer<BlogBloc , BlogState>(
        builder: (context, state) {
          if(state is BlogFailure){
            return Center(child: Text('Something Happen ${state.message}'),);
          }
          if(state is BlogLoading){
            return Loader();
          }
          if(state is BlogDisplaySuccessBlog){
            if(state.blogs.isEmpty){
              return Center(child: Text('We have no Any Blogs Currently'),);
            }
            return ListView.builder(itemBuilder: (context, index) {
              final blog = state.blogs[index];
              return BlogCard(
                  blog: blog,
                  color:index % 3==0 ? AppPallete.gradient1 : index % 3 ==1?AppPallete.gradient2 :AppPallete.gradient3
              );
            },
            itemCount: state.blogs.length,);
          }
          return SizedBox();
        },
        listener: (context, state) {

        },
      ),
    );
  }
}
