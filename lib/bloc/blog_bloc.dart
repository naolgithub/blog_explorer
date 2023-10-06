import 'package:blog_explorer/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc(this.blogRepository) : super(BlogLoadingState()) {
    on<LoadBlogEvent>((event, emit) async {
      emit(BlogLoadingState());
      try {
        final users = await blogRepository.getBlogs();
        emit(BlogLoadedState(users));
      } catch (e) {
        emit(BlogErrorState(e.toString()));
      }
    });
  }
}
