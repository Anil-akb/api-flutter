import 'package:api_demo/model/post.dart';
import 'package:api_demo/service/api_call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await ApiService().getPost();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // Add this line to center the title
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            posts![index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            posts![index].body ?? '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
