import 'dart:io';

import 'package:blog_app/core/Utils/Pick_Image.dart';
import 'package:blog_app/core/Utils/show_snake_bar.dart';
import 'package:blog_app/core/common/app_user/app_User_cubit.dart';
import 'package:blog_app/core/common/app_user/app_user_cubut_state.dart';
import 'package:blog_app/core/common/widgets/Loader.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogBloc.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogEvents.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogState.dart';
import 'package:blog_app/feacher/blog/Presentation/wiget/Blog_Editing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/AppPallete.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedChip = [];

  File? image;

  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage!=null){
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _uploadBlog(){
    if(formKey.currentState!.validate()&& selectedChip.isNotEmpty && image!=null){
      final posterid = (context.read<AppUserCubit>().state as AppUserLoggedIn ).user.id;
      context.read<BlogBloc>().add(BlogUpload(
          posterid: posterid,
          titile: titleController.text,
          content: contentController.text,
          image: image!,
          topics: selectedChip
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _uploadBlog,
            icon: const Icon(Icons.done_all_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<BlogBloc , BlogState>(
          listener: (context, state) {
            if(state is BlogFailure){
              showSnackbar(context, state.message);
            }
            if(state is BlogUploadSuccess){
              Navigator.pop(context);
              context.read<BlogBloc>().add(BlogFetchAllBlogs());
            }
          },
          builder: (context, state) {
            if(state is BlogLoading){
              return const Loader();
            }
            if(state is BlogFailure){
              return Center(child: Text(state.message,),);
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image !=null ?
                    GestureDetector(
                      onTap: () => selectImage(),
                      child: SizedBox(
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              )
                          )
                      ),
                    ):
                    GestureDetector(
                      onTap:() => selectImage(),
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(12),
                          color: AppPallete.borderColor,
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 30),
                              Text('Select Your Image'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                        [
                          'Technology',
                          'Business',
                          'Programming',
                          'Enterrainiment',
                        ]
                            .map(
                              (e) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if(selectedChip.contains(e)){
                                  selectedChip.remove(e);
                                }else{
                                  selectedChip.add(e);
                                }
                                setState(() {

                                });
                              },
                              child: Chip(
                                label: Text(e),
                                color: selectedChip.contains(e) ? WidgetStatePropertyAll(AppPallete.gradient1): null,
                                side: selectedChip.contains(e) ? null : BorderSide(color: AppPallete.borderColor),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    BlogEditing(controller: titleController, hintText: 'Name'),
                    BlogEditing(controller: contentController, hintText: 'Content'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
