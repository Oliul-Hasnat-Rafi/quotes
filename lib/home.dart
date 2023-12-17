import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:quotes/Hive/model_hive.dart';
import 'package:quotes/quotes_model.dart';
import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiUrl = "https://type.fit/api/quotes";
  List<quotes_model> quotesData = [];

  Future<List<quotes_model>> fetchQuotes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        quotesData = data.map((item) => quotes_model.fromJson(item)).toList();
        return quotesData;
      } else {
        throw Exception('Failed to fetch quotes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<quotes_model>>(
      future: fetchQuotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Quotes'));
        } else {
          return ListView.builder(
            itemCount: quotesData.length,
            itemBuilder: (context, index) {
              final quote = quotesData[index];
              return QuoteCard(quote: quote);
            },
          );
        }
      },
    );
  }
}

class QuoteCard extends StatefulWidget {
  final quotes_model quote;
  QuoteCard({required this.quote});

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool isFavorite = false; 
  @override
  void initState() {
    super.initState();
    isFavorite = box!.containsKey(widget.quote.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              widget.quote.text.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '--' + (widget.quote.author?.split(',').first.trim() ?? 'Unknown'),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });

                    if (isFavorite) {
                    
                      var data = model_hive(
                          quotes: widget.quote.text,
                          authorname:
                              widget.quote.author?.split(',').first.trim() ??
                                  'Unknown');
                      box!.put(widget.quote.text, data);
                      shoetoast('Quote added to favorites');
                    } else {
                      box!.delete(widget.quote.text);
                      shoetoast('Quote removed from favorites');
                    }
                  },
                  child: Chip(
                    label: Text('Favorite'),
                    avatar: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var copy =
                        Clipboard.setData(ClipboardData(text: widget.quote.text.toString()));
                    shoetoast(copy == ''
                        ? "Can't copy the Quote"
                        : 'Copied to clipboard');
                  },
                  child: Chip(
                    label: Text('Copy'),
                    avatar: Icon(Icons.copy_rounded),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void shoetoast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}