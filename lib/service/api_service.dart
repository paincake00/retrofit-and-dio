import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit_package/models/post_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: '') // another url
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  factory ApiService.init({
    String? url,
  }) {
    final apiUrl = url;
    final dio = Dio(BaseOptions(contentType: 'apllication/json'));
    if (apiUrl != null) {
      return ApiService(dio, baseUrl: apiUrl);
    }
    return ApiService(dio);
  }

  @GET('/posts')
  Future<List<PostModel>> getPosts();

  @GET('/posts')
  Future<List<PostModel>> getPostsFromQueries(
    @Queries() Map<String, dynamic> queries,
  );

  @GET('/posts')
  Future<List<PostModel>> getPostsFromQuery(
    @Query('id') int id,
    @Query('userId') int userId,
  );
}
