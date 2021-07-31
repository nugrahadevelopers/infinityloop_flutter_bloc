import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinityloop_flutter_bloc/posts/widgets/post_list_item.dart';

import 'bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();
  late PostBloc postBloc;

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      postBloc.add(PostEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    postBloc = BlocProvider.of<PostBloc>(context);
    scrollController.addListener(onScroll);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 36 + 20.0,
                    ),
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Coin Market Price',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Colors.blue.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  postBloc.add(PostEvent());
                                }
                                postBloc.add(FilterPostEvent(query: value));
                              },
                              controller: editingController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.blue.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostInitial) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      PostLoaded postLoaded = state as PostLoaded;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: (postLoaded.hasReachedMax)
                            ? postLoaded.posts!.length
                            : postLoaded.posts!.length + 1,
                        itemBuilder: (context, index) =>
                            (index < postLoaded.posts!.length)
                                ? PostListItem(postLoaded.posts![index])
                                : Container(
                                    child: Center(
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
