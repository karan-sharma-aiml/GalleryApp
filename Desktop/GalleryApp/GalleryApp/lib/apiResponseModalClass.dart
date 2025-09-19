class Photo {
  final int id;
  final String url;
  final String photographer;
  final String photographerUrl;
  final String photographerId;
  final String alt;
  final String imageUrl;

  Photo({
    required this.id,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.alt,
    required this.imageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'].toString(),
      alt: json['alt'] ?? '',
      imageUrl: json['src']['medium'], // You can use different size images as per your requirement.
    );
  }
}
