
import 'dart:io';

import 'package:blog_app/core/error/ServerException.dart';
import 'package:blog_app/feacher/blog/Data/model/Blog_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog({required BlogModel blog});
  Future<String> uploadBlogImage({
    required File file , required BlogModel blog
  });

  Future<List<BlogModel>> getAllBlogs() ;
}

class BlogRemotedataSourceImpl implements BlogRemoteDataSource{
  final SupabaseClient supabaseClient ;

  BlogRemotedataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async{
    try{
      final data = await supabaseClient.from('blogs').insert(blog.tojson()).select();
      final thisblog  =data.first;
      return BlogModel.fromJson(thisblog);
    }catch (e){
      print('erros is$e');
      throw ServerExeception(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File file,
    required BlogModel blog
  }) async{
    try{
       await supabaseClient.storage.from('images').upload(blog.id, file, fileOptions: FileOptions(
         upsert: true,
         contentType: 'image/*'
       ));
      return supabaseClient.storage.from('images').getPublicUrl(blog.id);
    }on UnsupportedError catch(e){
      throw ServerExeception(e.stackTrace.toString());
    }on StorageException catch(e){
      print("erros is${e.message}");
      throw StorageException(e.message);
    }
    catch(e){
      throw ServerExeception(e.runtimeType.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async{
    try{
      final blogs = await supabaseClient.from('blogs').select('*,profiles(name)');
      if(blogs.isEmpty){
        return [];
      }
      return blogs.map((e) => BlogModel.fromJson(e).copyWith(
        posterName: e['profiles']['name'] as String?,
      )).toList();
    }catch(e){
      throw ServerExeception(e.toString());
    }
  }
}