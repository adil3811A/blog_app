

import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/blog/Domain/useCases/Upload_Blog.dart';
import 'package:blog_app/feacher/blog/Domain/useCases/get_all_Blog.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogEvents.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent , BlogState>{

  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
}): _uploadBlog = uploadBlog,
  _getAllBlogs = getAllBlogs,
        super(BlogInit()){
    on<BlogEvent>((event, emit) => emit(BlogLoading()),);
    on<BlogUpload>(_uploadBlogFn);
    on<BlogFetchAllBlogs>(_getAllBlogEvent);
  }

  void _getAllBlogEvent(
      BlogFetchAllBlogs event,
      Emitter<BlogState> emit,
      ) async{
    final result =await  _getAllBlogs.call(NoPeram());
    result.fold((l) => emit(BlogFailure(l.message)), (r) =>emit(BlogDisplaySuccessBlog(r)) ,);
  }

  void _uploadBlogFn(
      BlogUpload event,
      Emitter<BlogState> emit
      ) async{
    final responce =await _uploadBlog.call(UploadBlogParam(
        posterid: event.posterid,
        titile: event.titile,
        content: event.content,
        image: event.image,
        topics: event.topics
    ));
    responce.fold(
          (l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogUploadSuccess(r)),
    );
  }

}