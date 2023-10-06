import 'package:blog_explorer/constants/size_constants.dart';
import 'package:flutter/material.dart';

class DetailedBlogList extends StatefulWidget {
  final String title;
  final String imageUrl;
  const DetailedBlogList({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<DetailedBlogList> createState() => _DetailedBlogListState();
}

class _DetailedBlogListState extends State<DetailedBlogList> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detailed BlogList'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: Sizes.dimen_50),
            Card(
              elevation: Sizes.dimen_4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.dimen_10,
                  ),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(
                Sizes.dimen_16,
                0,
                Sizes.dimen_16,
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
                    child: Stack(
                      children: [
                        Image.network(
                          widget.imageUrl,
                          height: 380,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          // if the image is null
                          errorBuilder: (BuildContext context, Object exception,
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
                                child: Icon(Icons.broken_image_outlined),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          right: Sizes.dimen_5,
                          top: Sizes.dimen_5,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: isFavorite
                                ? Container(
                                    width: Sizes.dimen_60,
                                    height: Sizes.dimen_60,
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
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: Sizes.dimen_50,
                                    ),
                                  )
                                : Container(
                                    width: Sizes.dimen_60,
                                    height: Sizes.dimen_60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        // width: 2,
                                        color: Colors.blueGrey,
                                      ),
                                      // shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.amber[300],
                                      // color: Colors.white,
                                      size: Sizes.dimen_50,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.dimen_6),
                    child: SizedBox(
                      height: 80,
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: Sizes.dimen_20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(Sizes.dimen_6),
                  //   child: Text(
                  //     widget.title,
                  //     maxLines: 2,
                  //     style: const TextStyle(
                  //       color: Colors.black54,
                  //       fontSize: Sizes.dimen_14,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
