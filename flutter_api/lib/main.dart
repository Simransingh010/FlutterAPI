import 'package:flutter/material.dart';
import 'package:flutter_api/api_service.dart';
import 'package:flutter_api/models/users_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.purple,
        title: Padding(
          padding: const EdgeInsets.only(left: 70, top: 40),
          child: Text(
            "Flutter API Testing",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.cancel),
      ),
    );
  }
}

FutureBuilder<List<User>> _buildBody(BuildContext context) {
  final HttpService httpService = HttpService();

  return FutureBuilder<List<User>>(
      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final List<User> posts = snapshot.data!;
            return _buildPosts(context, posts);
          } else {
            // Handle the case where snapshot.data is null
            return const Center(
              child:
                  Text('No data available'), // Or any other appropriate widget
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

ListView _buildPosts(BuildContext context, List<User> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Card(
              color: Colors.white10,
              elevation: 1,
              child: ListTile(
                title: Text(
                  posts[index].title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                subtitle: Text(posts[index].body),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    },
  );
}
