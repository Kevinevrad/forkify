class SearchRecipeData {
  final String publisher;
  final String id;
  final String title;
  final String imageUrl;

  SearchRecipeData({
    required this.publisher,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory SearchRecipeData.fromJson(Map<String, dynamic> json) {
    return SearchRecipeData(
      publisher: json['publisher'],
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
