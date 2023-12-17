class quotes_model { String? text;
  String? author; 
 

  quotes_model({this.text, this.author});

  quotes_model.fromJson(dynamic json) {
    text = json['text'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['author'] = this.author;
    return data;
  }
}
