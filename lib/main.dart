import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinityloop_flutter_bloc/posts/bloc/post_bloc.dart';
import 'package:infinityloop_flutter_bloc/posts/post_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<PostBloc>(
        create: (context) => PostBloc()..add(PostEvent()),
        child: PostPage(),
      ),
    );
  }
}
