import 'package:dio/dio.dart';
import 'package:retrofit_package/models/post_model.dart';

class DioClient {
  static Dio dioClientInit({String? apiUrl}) {
    if (apiUrl != null) {
      return Dio(BaseOptions(contentType: 'application/json', baseUrl: apiUrl));
    }
    return Dio(BaseOptions(contentType: 'application/json'));
  }

  static Future<PostModel?>? createPost(
      Dio dio, Map<String, dynamic> post) async {
    try {
      Response<dynamic> response =
          await dio.post<Map<dynamic, dynamic>>('/posts', data: post);

      final model = PostModel.fromJson(response.data);
      return model;
    } on DioException catch (_) {
      return null;
    }
  }

  static Future<PostModel?>? updatePost(
      Dio dio, int id, Map<String, dynamic> post) async {
    try {
      Response<dynamic> response =
          await dio.put<Map<dynamic, dynamic>>('/posts/$id', data: post);

      final model = PostModel.fromJson(response.data);
      return model;
    } on DioException catch (_) {
      return null;
    }
  }

  static Future<PostModel?> deletePost(Dio dio, int id) async {
    final result = await dio.delete<Map<String, dynamic>>('/posts/$id');

    if (result.data != null) {
      return PostModel.fromJson({
        'id': id,
        'userId': 0,
        'title': 'DELETED SUCCESSFULLY',
        'body': '',
      });
    }

    return null;
  }
}
