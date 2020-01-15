class Eintrag {
  bool _minus;
  num _betrag;
  dynamic _category;
  dynamic _datum;

  /*Eintrag(bool minus, num betrag, dynamic cat){
    this._minus = minus;
    this._betrag = betrag;
    this._category = cat;
    this._datum = new DateTime.now();

  }*/

  Eintrag(this._minus, this._betrag, this._category, this._datum);

  factory Eintrag.fromJson(Map<String, dynamic> json) {
    return new Eintrag(
      json['_minus'],
      json['_betrag'],
      json['_category'],
      json['_datum'],
    );
  }

  num getBetrag() {
    if (_minus)
      return _betrag * -1;
    else
      return _betrag;
  }

  dynamic getCat() {
    return _category;
  }

  dynamic getDatum() {
    return _datum;
  }
}
