part of 'post_bloc.dart';

@immutable
class PostEvent {}

class FilterPostEvent extends PostEvent {
  final String? query;

  FilterPostEvent({this.query});
}
