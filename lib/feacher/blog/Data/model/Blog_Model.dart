import 'package:blog_app/feacher/blog/Domain/Entity/Blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'updated_at': updatedAt.toIso8601String(),
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topic': topics,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
        topics: List<String>.from(map['topic'] as List),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at'] as String),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName?? this.posterName,
    );
  }
}
