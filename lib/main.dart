import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:retrofit_package/pages/get_from_id.dart';
import 'package:retrofit_package/pages/post_and_put.dart';
import 'package:retrofit_package/providers/api_provider.dart';
import 'package:retrofit_package/service/api_service.dart';
import 'package:retrofit_package/service/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final client = ApiService.init(url: dotenv.env['API_URL']);
  final dio = DioClient.dioClientInit(apiUrl: dotenv.env['API_URL']);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiProvider()
        ..setRetrofit(client)
        ..setDio(dio),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Retrofit & Dio',
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: PageView(
          children: const [
            GetFromId(),
            PostAndPut(),
          ],
        ),
      ),
    );
  }
}
