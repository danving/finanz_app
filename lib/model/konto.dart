import 'eintrag.dart';

class Konto{
  num _kontostand;
  List<Eintrag> eintraege = [];

  Konto(num kontostand){
    this._kontostand = kontostand;
    addEintrag(new Eintrag(false, 0.0, "Init"));
  }

  num getKontostand(){
    _kontostand = 0;
    for(int i = 0; i < eintraege.length; i++){
      _kontostand += eintraege[i].getBetrag();
    }
    //_kontostand +=eintraege[eintraege.length-1].getBetrag();

    return _kontostand;
  }

  void addEintrag(Eintrag newEintag){
    eintraege.add(newEintag);
  }

  int getCountEintraege(){
    return eintraege.length;
  }
}