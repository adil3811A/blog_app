

import 'package:blog_app/feacher/blog/Data/model/Blog_Model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource{
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource{

  final Box box;

  BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> list = [];
    box.read(() {
      for(int i =0 ; i<box.length ; i++){
        list.add(BlogModel.fromJson(box.get(i.toString())));
      }
    },);
    return list;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write((){
      for(int i =0 ; i <blogs.length ; i++){
        box.put(i.toString(), blogs[i].tojson());
      }
    },);
  }

}