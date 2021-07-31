import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:infinityloop_flutter_bloc/posts/models/post_model.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    List<PostModel> posts;

    if (event is FilterPostEvent) {
      String? query = event.query;
      PostLoaded postLoaded = state as PostLoaded;

      yield postLoaded.filteredList(posts: postLoaded.posts, query: query);
    } else {
      if (state is PostInitial) {
        posts = await PostModel.connectToAPI(0, 10);
        yield PostLoaded(
          posts: posts,
          hasReachedMax: false,
        );
      } else {
        PostLoaded postLoaded = state as PostLoaded;
        posts = await PostModel.connectToAPI(postLoaded.posts!.length, 10);

        yield (posts.isEmpty)
            ? postLoaded.copyWith(hasReachedMax: true)
            : PostLoaded(
                posts: postLoaded.posts! + posts, hasReachedMax: false);
      }
    }
  }
}
