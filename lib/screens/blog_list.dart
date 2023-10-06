import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/bloc/blog_event.dart';
import 'package:blog_explorer/constants/size_constants.dart';
import 'package:blog_explorer/model/blog_model.dart';
import 'package:blog_explorer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_state.dart';
import 'detailed_blog_list.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  bool isFavorite = false;
  final blogRepository = BlogRepository();
  @override
  void initState() {
    super.initState();
    blogRepository.getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 7,
              ),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    // width: 2,
                    color: Colors.blueGrey,
                  ),
                  // shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_vert_sharp,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
          title: const Text(
            'Subspace',
            style: TextStyle(
              fontSize: Sizes.dimen_30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueGrey,
          // centerTitle: true,
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => BlogBloc(
        BlogRepository(),
      )..add(LoadBlogEvent()),
      child: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BlogLoadedState) {
            List<BlogModel> userList = state.blogs;
            return FutureBuilder(
              builder: (context, snapshot) {
                // WHILE THE CALL IS BEING MADE AKA LOADING
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading'));
                }

                // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                // IF IT WORKS IT GOES HERE!
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.dimen_4,
                          horizontal: Sizes.dimen_20,
                        ),
                        child:

                            // Card(
                            //   // color: Theme.of(context).primaryColor,
                            //   color: Colors.brown,
                            //   child: ListTile(
                            //     title: Text(
                            //       ' ${userList[index].title}',
                            //       style: const TextStyle(
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     subtitle: Text(
                            //       '${userList[index].title}',
                            //       style: const TextStyle(
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     leading: CircleAvatar(
                            //       backgroundImage: NetworkImage(
                            //         userList[index].imageUrl.toString(),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            //     Container(
                            //   decoration: const BoxDecoration(),
                            //   width: MediaQuery.of(context).size.width / .2,
                            //   height: 30,
                            //   child: Text(
                            //     ' ${userList[index].title}',
                            //     style: const TextStyle(
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),

                            InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedBlogList(
                                  title: "${userList[index].title}",
                                  imageUrl: "${userList[index].imageUrl}",
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: Sizes.dimen_4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Sizes.dimen_10,
                                ),
                              ),
                            ),
                            margin: const EdgeInsets.fromLTRB(
                              Sizes.dimen_5,
                              0,
                              Sizes.dimen_5,
                              Sizes.dimen_16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(Sizes.dimen_10),
                                    topRight: Radius.circular(Sizes.dimen_10),
                                  ),
                                  child: Image.network(
                                    "${userList[index].imageUrl}",
                                    height: Sizes.dimen_200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                    // if the image is null
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.dimen_10,
                                          ),
                                        ),
                                        child: const SizedBox(
                                          height: Sizes.dimen_200,
                                          width: double.infinity,
                                          child: Icon(
                                            Icons.broken_image_outlined,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: Sizes.dimen_16),
                                Padding(
                                  padding: const EdgeInsets.all(Sizes.dimen_6),
                                  child: Text(
                                    "${userList[index].title}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: Sizes.dimen_20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(Sizes.dimen_6),
                                  child: Text(
                                    "${userList[index].title}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: Sizes.dimen_14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              future: blogRepository.getBlogs(),
            );
          }
          // if (state is BlogErrorState) {
          //   return const Center(
          //     child: Text("Error"),
          //   );
          // }

          return Container();
        },
      ),
    );
  }
}
