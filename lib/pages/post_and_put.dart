import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_package/models/post_model.dart';
import 'package:retrofit_package/providers/api_provider.dart';
import 'package:retrofit_package/service/dio_client.dart';

class PostAndPut extends StatefulWidget {
  const PostAndPut({super.key});

  @override
  State<PostAndPut> createState() => _PostAndPutState();
}

class _PostAndPutState extends State<PostAndPut> {
  Future<PostModel?>? fetchedFutureModel;

  late Dio dio;

  @override
  void initState() {
    dio = context.read<ApiProvider>().dio;

    super.initState();
  }

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _idForDeleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    height: 400,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 6, left: 6, top: 12),
                              child: SizedBox(
                                width: 160,
                                height: 50,
                                child: TextField(
                                  controller: _idController,
                                  decoration: const InputDecoration(
                                    labelText: 'id (PUT)',
                                    border: OutlineInputBorder(),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 6, left: 6, top: 12),
                              child: SizedBox(
                                width: 160,
                                height: 50,
                                child: TextField(
                                  controller: _userIdController,
                                  decoration: const InputDecoration(
                                    labelText: 'user id',
                                    border: OutlineInputBorder(),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 6, left: 6, top: 12),
                          child: SizedBox(
                            width: 332,
                            height: 50,
                            child: TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'title',
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 6, left: 6, top: 12),
                          child: SizedBox(
                            width: 332,
                            height: 50,
                            child: TextField(
                              controller: _bodyController,
                              decoration: const InputDecoration(
                                labelText: 'body',
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_idController.text.isNotEmpty &&
                                _userIdController.text.isNotEmpty &&
                                _titleController.text.isNotEmpty &&
                                _bodyController.text.isNotEmpty) {
                              clickPut(_idController.text, {
                                'userId': _userIdController.text,
                                'title': _titleController.text,
                                'body': _bodyController.text,
                              });
                            } else if (_userIdController.text.isNotEmpty &&
                                _titleController.text.isNotEmpty &&
                                _bodyController.text.isNotEmpty) {
                              clickPost({
                                'userId': _userIdController.text,
                                'title': _titleController.text,
                                'body': _bodyController.text,
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                              width: 332,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 1),
                              ),
                              child: const Center(
                                child: Text(
                                  'POST | PUT',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6, top: 36),
                              child: SizedBox(
                                width: 160,
                                height: 50,
                                child: TextField(
                                  controller: _idForDeleteController,
                                  decoration: const InputDecoration(
                                    labelText: 'id (DELETE)',
                                    border: OutlineInputBorder(),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_idForDeleteController.text.isNotEmpty) {
                                  clickDelete(_idForDeleteController.text);
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, top: 36),
                                child: Container(
                                  width: 160,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'DELETE',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: const Center(
              child: Text(
                'POST',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  FutureBuilder _body() {
    return FutureBuilder(
      future: fetchedFutureModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('offline mode!\n${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return _post(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _post(PostModel post) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        // width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black38, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ID: ${post.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'User ID: ${post.userId}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              post.body,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void clickPost(Map<String, dynamic> post) {
    setState(() {
      fetchedFutureModel = DioClient.createPost(dio, post);
    });
  }

  void clickPut(String id, Map<String, dynamic> post) {
    setState(() {
      fetchedFutureModel = DioClient.updatePost(dio, int.parse(id), post);
    });
  }

  void clickDelete(String id) {
    setState(() {
      fetchedFutureModel = DioClient.deletePost(dio, int.parse(id));
    });
  }
}
