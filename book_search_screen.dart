import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_model.dart';

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';


  final String apiUrl = 'http://authorsearch.infinityfreeapp.com/index.php';


  final Map<String, List<Book>> genreBooks = {
    'Romance': [
      Book(title: 'Pride and Prejudice', author: 'Jane Austen', subject: 'Romance', imageUrl: 'https://covers.openlibrary.org/b/id/8671261-L.jpg'),
      Book(title: 'The Notebook', author: 'Nicholas Sparks', subject: 'Romance', imageUrl: 'https://covers.openlibrary.org/b/id/8044451-L.jpg'),
      Book(title: 'Twilight', author: 'Stephenie Meyer', subject: 'Romance', imageUrl: 'https://covers.openlibrary.org/b/id/7443127-L.jpg'),
      Book(title: 'Me Before You', author: 'Jojo Moyes', subject: 'Romance', imageUrl: 'https://covers.openlibrary.org/b/id/8091466-L.jpg'),
      Book(title: 'The Fault in Our Stars', author: 'John Green', subject: 'Romance', imageUrl: 'https://covers.openlibrary.org/b/id/7898681-L.jpg'),
    ],
    'Horror': [
      Book(title: 'The Shining', author: 'Stephen King', subject: 'Horror', imageUrl: 'https://covers.openlibrary.org/b/id/7683287-L.jpg'),
      Book(title: 'It', author: 'Stephen King', subject: 'Horror', imageUrl: 'https://covers.openlibrary.org/b/id/7994295-L.jpg'),
      Book(title: 'Dracula', author: 'Bram Stoker', subject: 'Horror', imageUrl: 'https://covers.openlibrary.org/b/id/8358039-L.jpg'),
      Book(title: 'The Haunting of Hill House', author: 'Shirley Jackson', subject: 'Horror', imageUrl: 'https://covers.openlibrary.org/b/id/8636070-L.jpg'),
      Book(title: 'Frankenstein', author: 'Mary Shelley', subject: 'Horror', imageUrl: 'https://covers.openlibrary.org/b/id/8305862-L.jpg'),
    ],
    'Fantasy': [
      Book(title: 'The Hobbit', author: 'J.R.R. Tolkien', subject: 'Fantasy', imageUrl: 'https://covers.openlibrary.org/b/id/7894674-L.jpg'),
      Book(title: 'Harry Potter and the Sorcerer\'s Stone', author: 'J.K. Rowling', subject: 'Fantasy', imageUrl: 'https://covers.openlibrary.org/b/id/7611592-L.jpg'),
      Book(title: 'The Name of the Wind', author: 'Patrick Rothfuss', subject: 'Fantasy', imageUrl: 'https://covers.openlibrary.org/b/id/7804561-L.jpg'),
      Book(title: 'The Way of Kings', author: 'Brandon Sanderson', subject: 'Fantasy', imageUrl: 'https://covers.openlibrary.org/b/id/7645897-L.jpg'),
      Book(title: 'Mistborn', author: 'Brandon Sanderson', subject: 'Fantasy', imageUrl: 'https://covers.openlibrary.org/b/id/7770579-L.jpg'),
    ],
    'Sci-Fi': [
      Book(title: 'Dune', author: 'Frank Herbert', subject: 'Sci-Fi', imageUrl: 'https://covers.openlibrary.org/b/id/7466565-L.jpg'),
      Book(title: 'Ender\'s Game', author: 'Orson Scott Card', subject: 'Sci-Fi', imageUrl: 'https://covers.openlibrary.org/b/id/7588041-L.jpg'),
      Book(title: 'I, Robot', author: 'Isaac Asimov', subject: 'Sci-Fi', imageUrl: 'https://covers.openlibrary.org/b/id/7681610-L.jpg'),
      Book(title: 'The Left Hand of Darkness', author: 'Ursula K. Le Guin', subject: 'Sci-Fi', imageUrl: 'https://covers.openlibrary.org/b/id/8356034-L.jpg'),
      Book(title: 'Neuromancer', author: 'William Gibson', subject: 'Sci-Fi', imageUrl: 'https://covers.openlibrary.org/b/id/7486009-L.jpg'),
    ],
    'Mystery': [
      Book(title: 'The Girl with the Dragon Tattoo', author: 'Stieg Larsson', subject: 'Mystery', imageUrl: 'https://covers.openlibrary.org/b/id/7634185-L.jpg'),
      Book(title: 'Gone Girl', author: 'Gillian Flynn', subject: 'Mystery', imageUrl: 'https://covers.openlibrary.org/b/id/7438639-L.jpg'),
      Book(title: 'Sherlock Holmes', author: 'Arthur Conan Doyle', subject: 'Mystery', imageUrl: 'https://covers.openlibrary.org/b/id/7915616-L.jpg'),
      Book(title: 'Big Little Lies', author: 'Liane Moriarty', subject: 'Mystery', imageUrl: 'https://covers.openlibrary.org/b/id/7760667-L.jpg'),
      Book(title: 'The Silent Patient', author: 'Alex Michaelides', subject: 'Mystery', imageUrl: 'https://covers.openlibrary.org/b/id/8046697-L.jpg'),
    ],
    'Thriller': [
      Book(title: 'The Girl on the Train', author: 'Paula Hawkins', subject: 'Thriller', imageUrl: 'https://covers.openlibrary.org/b/id/7880175-L.jpg'),
      Book(title: 'The Silent Corner', author: 'Dean Koontz', subject: 'Thriller', imageUrl: 'https://covers.openlibrary.org/b/id/8184343-L.jpg'),
      Book(title: 'Before I Go to Sleep', author: 'S.J. Watson', subject: 'Thriller', imageUrl: 'https://covers.openlibrary.org/b/id/7585905-L.jpg'),
      Book(title: 'The Woman in the Window', author: 'A.J. Finn', subject: 'Thriller', imageUrl: 'https://covers.openlibrary.org/b/id/7880809-L.jpg'),
      Book(title: 'Sharp Objects', author: 'Gillian Flynn', subject: 'Thriller', imageUrl: 'https://covers.openlibrary.org/b/id/7827074-L.jpg'),
    ],
    'Biography': [
      Book(title: 'The Diary of a Young Girl', author: 'Anne Frank', subject: 'Biography', imageUrl: 'https://covers.openlibrary.org/b/id/7826874-L.jpg'),
      Book(title: 'Becoming', author: 'Michelle Obama', subject: 'Biography', imageUrl: 'https://covers.openlibrary.org/b/id/8095062-L.jpg'),
      Book(title: 'Steve Jobs', author: 'Walter Isaacson', subject: 'Biography', imageUrl: 'https://covers.openlibrary.org/b/id/8235067-L.jpg'),
      Book(title: 'Educated', author: 'Tara Westover', subject: 'Biography', imageUrl: 'https://covers.openlibrary.org/b/id/7982562-L.jpg'),
      Book(title: 'When Breath Becomes Air', author: 'Paul Kalanithi', subject: 'Biography', imageUrl: 'https://covers.openlibrary.org/b/id/7634537-L.jpg'),
    ],
    'Non-Fiction': [
      Book(title: 'Sapiens', author: 'Yuval Noah Harari', subject: 'Non-Fiction', imageUrl: 'https://covers.openlibrary.org/b/id/8637175-L.jpg'),
      Book(title: 'Educated', author: 'Tara Westover', subject: 'Non-Fiction', imageUrl: 'https://covers.openlibrary.org/b/id/7982562-L.jpg'),
      Book(title: 'Becoming', author: 'Michelle Obama', subject: 'Non-Fiction', imageUrl: 'https://covers.openlibrary.org/b/id/8095062-L.jpg'),
      Book(title: 'The Immortal Life of Henrietta Lacks', author: 'Rebecca Skloot', subject: 'Non-Fiction', imageUrl: 'https://covers.openlibrary.org/b/id/7360960-L.jpg'),
      Book(title: 'The Wright Brothers', author: 'David McCullough', subject: 'Non-Fiction', imageUrl: 'https://covers.openlibrary.org/b/id/7566544-L.jpg'),
    ],
  };

  List<Book> _filteredBooks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredBooks = _getAllBooks();
  }


  List<Book> _getAllBooks() {
    List<Book> books = [];
    genreBooks.forEach((genre, booksInGenre) {
      books.addAll(booksInGenre);
    });
    return books;
  }


  void _searchBooks(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredBooks = _getAllBooks().where((book) {
        return book.title.toLowerCase().contains(_searchQuery) ||
            book.author.toLowerCase().contains(_searchQuery) ||
            book.subject.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search books by author or subject',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: _filteredBooks.isEmpty
                  ? Center(child: Text('No books found'))
                  : ListView.builder(
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = _filteredBooks[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        book.imageUrl.isNotEmpty
                            ? Image.network(book.imageUrl, width: 100, height: 150, fit: BoxFit.cover)
                            : Icon(Icons.book, size: 100),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                book.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Author: ${book.author}'),
                              Text('Subject: ${book.subject}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
