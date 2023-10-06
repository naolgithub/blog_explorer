class BlogModel {
  String? id;
  String? title;
  String? imageUrl;

  BlogModel({
    this.id,
    this.title,
    this.imageUrl,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
  }
}
