class Calculator{
  double _add;
  double _remove;
  double _kontostand;

  Calculator(this._add, this._remove, this._kontostand);

  void calculateAdd(){
    _kontostand += _add;
  }

  void calculateRemove(){
    _kontostand -= _remove;
  }

}