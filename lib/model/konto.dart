import 'eintrag.dart';

class Konto{
  num _kontostand;
  List<Eintrag> eintraege = [];

  Konto(num kontostand){
    this._kontostand = kontostand;
    addEintrag(new Eintrag(false, 0.0, "Init", new DateTime.now()));
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
    return _kontostand;
  }

  void addEintrag(Eintrag newEintag){
    eintraege.add(newEintag);
  }

  int getCountEintraege(){
    return eintraege.length;
  }
}