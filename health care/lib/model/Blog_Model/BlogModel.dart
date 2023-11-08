// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  final String? status;
  final List<Blog>? blog;

  BlogModel({
    this.status,
    this.blog,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    status: json["status"],
    blog: json["blog"] == null ? [] : List<Blog>.from(json["blog"]!.map((x) => Blog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "blog": blog == null ? [] : List<dynamic>.from(blog!.map((x) => x.toJson())),
  };
}

class Blog {
  final int? id;
  final String? title;
  final String? slug;
  final String? tags;
  final String? description;
  final String? image;
  final String? visits;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Blog({
    this.id,
    this.title,
    this.slug,
    this.tags,
    this.description,
    this.image,
    this.visits,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    tags: json["tags"],
    description: json["description"],
    image: json["image"],
    visits: json["visits"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "tags": tags,
    "description": description,
    "image": image,
    "visits": visits,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
