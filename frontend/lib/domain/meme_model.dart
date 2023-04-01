import '../utils/helpers.dart';

class MemeModel {
  MemeModel({
    required this.id,
    required this.creatorId,
    required this.creatorUsername,
    required this.data,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });
  late final int id;
  late final int creatorId;
  late final String creatorUsername;
  late final String data;
  late final DateTime createdAt;
  late final List<Likes> likes;
  late final List<Comments> comments;


  MemeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creatorId'];
    creatorUsername = json['creatorUsername'];
    data = json['data'];
    createdAt = DateTime.parse(json['createdAt']);
    likes = List.from(json['likes']).map((e)=>Likes.fromJson(e)).toList();
    comments = List.from(json['comments']).map((e)=>Comments.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Likes {
  Likes({
    required this.id,
    required this.likerId,
    required this.likerUsername,
    required this.likedAt,
  });
  late final int id;
  late final int likerId;
  late final String likerUsername;
  late final DateTime likedAt;

  Likes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    likerId = json['likerId'];
    likerUsername = json['likerUsername'];
    likedAt = DateTime.parse(json['likedAt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }

}

class Comments {
  Comments({
    required this.id,
    required this.commenterId,
    required this.commenterUsername,
    required this.comment,
    required this.commentedAt,
  });
  late final int id;
  late final int commenterId;
  late final String commenterUsername;
  late final String comment;
  late final DateTime commentedAt;


  Comments.fromJson(Map<String, dynamic> json){
    id = json['id'];
    commenterId = json['commenterId'];
    commenterUsername = json['commenterUsername'];
    comment = json['comment'];
    commentedAt = DateTime.parse(json['commentedAt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }

}