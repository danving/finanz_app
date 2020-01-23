import 'dart:convert';

Eintrag clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Eintrag.fromMap(jsonData);
}

String clientToJson(Eintrag data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Eintrag {
  int id;
  bool minus;
  num amount;
  String category;
  String usage;
  String date;

  Eintrag(bool minus, num amount, String cat, String usage, String datum){
    //this.id = id;
    this.minus = minus;
    this.amount = amount;
    this.category = cat;
    this.usage = usage;
    this.date = datum;
  }

  Eintrag.database({
    this.id,
    this.minus,
    this.amount,
    this.category,
    this.usage,
    this.date
});


  factory Eintrag.fromMap(Map<String, dynamic> json) => new Eintrag.database(
    id: json["id"],
    minus: json["minus"] == 1,
    amount: json["amount"],
    category: json["category"],
    usage: json['usage'],
    date: json["date"],
  );

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'minus' : minus,
      'amount' : amount,
      'category' : category,
      'usage' : usage,
      'date' : date,
    };
  }
}
