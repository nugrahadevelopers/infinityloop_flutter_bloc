part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel>? posts;
  final bool hasReachedMax;

  PostLoaded({
    this.posts,
    required this.hasReachedMax,
  });

  PostLoaded copyWith({List<PostModel>? posts, bool? hasReachedMax}) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  PostLoaded filteredList({List<PostModel>? posts, String? query}) {
    return PostLoaded(
      posts: posts!
          .where((element) =>
              element.title.toLowerCase().contains(query!.toLowerCase()))
          .toList(),
      hasReachedMax: this.hasReachedMax,
    );
  }
}
