class Book {
  final String title;
  final String author;
  final String subject;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.subject,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'Unknown Author',
      subject: json['subject'] ?? 'Unknown Subject',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
