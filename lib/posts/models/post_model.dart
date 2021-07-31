import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  int id;
  String title;
  String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  static Future<List<PostModel>> connectToAPI(int start, int limit) async {
    var apiURL = Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_start=" +
            start.toString() +
            "&_limit=" +
            limit.toString());

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body) as List;

    return jsonObject.map((post) => PostModel.fromJson(post)).toList();
  }
}
