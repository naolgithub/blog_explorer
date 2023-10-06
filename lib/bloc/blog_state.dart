import 'package:blog_explorer/model/blog_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BlogState extends Equatable {}

//data loading state
class BlogLoadingState extends BlogState {
  @override
  List<Object?> get props => [];
}

class BlogLoadedState extends BlogState {
  final List<BlogModel> blogs;
  BlogLoadedState(this.blogs);
  @override
  List<Object?> get props => [blogs];
}

class BlogErrorState extends BlogState {
  final String error;
  BlogErrorState(this.error);
  @override
  List<Object?> get props => [error];
}


//data loaded state


//data loading error state
