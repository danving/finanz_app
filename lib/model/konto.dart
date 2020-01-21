import 'dart:io';

import 'eintrag.dart';
import 'storage.dart';


class Konto {
  num _kontostand;
  List<Eintrag> eintraege = [];

  //Storage
  final Storage storage = new Storage();
  String state;
  Future<Directory> _appDocDir;

  Konto(num kontostand){
    this._kontostand = kontostand;
    //addEintrag(new Eintrag(false, 0.0, "Init", new DateTime.now()));
  }

  Konto.json({this.eintraege,});

  factory Konto.fromJson(List<dynamic> parsedJson){
    List<Eintrag> eintraege = new List<Eintrag>();

    return new Konto.json(eintraege: eintraege);
  }

  num getKontostand(){
    _kontostand = 0;
    for(int i = 0; i < eintraege.length; i++){
      _kontostand += eintraege[i].getBetrag();
    }
    //return _kontostand;
    return _kontostand;
  }

  void addEintrag(Eintrag newEintag){
    eintraege.add(newEintag);
  }

  int getCountEintraege(){
    return eintraege.length;
  }

  void initKonto(){
    storage.readData().then((String value){
      state = value;
    });
  }

  void writeKontostand(){
    storage.writeData(_kontostand.toString());
  }

}