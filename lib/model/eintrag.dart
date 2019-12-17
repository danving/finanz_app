class Eintrag{
  bool _minus;
  num _betrag;
  dynamic _category;
  dynamic _datum;

  Eintrag(bool minus, num betrag, dynamic cat){
    this._minus = minus;
    this._betrag = betrag;
    this._category = cat;
    this._datum = new DateTime.now();

  }

  num getBetrag(){
    if(_minus)return _betrag*-1;
    else return _betrag;
  }

  dynamic getCat(){
    return _category;
  }

  dynamic getDatum(){
    return _datum;
  }
}