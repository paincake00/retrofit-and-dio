import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_package/models/post_model.dart';
import 'package:retrofit_package/providers/api_provider.dart';
import 'package:retrofit_package/service/api_service.dart';

class GetFromId extends StatefulWidget {
  const GetFromId({super.key});

  @override
  State<GetFromId> createState() => _GetFromIdState();
}

class _GetFromIdState extends State<GetFromId> {
  Future<List<PostModel>>? data;

  late ApiService apiService;

  @override
  void initState() {
    apiService = context.read<ApiProvider>().retrofitClient;
    // Provider.of<ApiProvider>(context, listen: false).retrofitClient;

    super.initState();
  }
  // ApiService(Dio(BaseOptions(contentType: 'application/json')));

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'id',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  // onSubmitted: (value) {
                  //   clickGetQuery(int.parse(value), 1);
                  // },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 100,
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
                  // onSubmitted: (value) {
                  //   clickGetQuery(int.parse(value), 1);
                  // },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_idController.text.isNotEmpty &&
                    _userIdController.text.isNotEmpty) {
                  clickGetQuery(
                    int.parse(_idController.text),
                    int.parse(_userIdController.text),
                  );
                } else if (_idController.text.isNotEmpty) {
                  clickGetQueries({'id': int.parse(_idController.text)});
                } else if (_userIdController.text.isNotEmpty) {
                  clickGetQueries(
                      {'userId': int.parse(_userIdController.text)});
                } else {
                  clickGet();
                }
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
                    'GET',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  FutureBuilder _body() {
    return FutureBuilder(
        // future: apiService.getPost(1),
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('offline mode!'),
            );
          } else if (snapshot.hasData) {
            return _posts(snapshot.data!);

            // return _posts([snapshot.data!]);
          } else {
            return Container();
          }
        });
  }

  Widget _posts(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black38, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${posts[index].id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'User ID: ${posts[index].userId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                posts[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                posts[index].body,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void clickGetQuery(int id, int userId) {
    setState(() {
      data = apiService.getPostsFromQuery(id, userId);
    });
  }

  void clickGetQueries(Map<String, dynamic> queries) {
    setState(() {
      data = apiService.getPostsFromQueries(queries);
    });
  }

  void clickGet() {
    setState(() {
      data = apiService.getPosts();
    });
  }
}
