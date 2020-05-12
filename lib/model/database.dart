import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'eintrag.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Eintrag ("
            "id INTEGER PRIMARY KEY,"
            "minus BIT,"
            "amount Double,"
            "category TEXT,"
            "usage TEXT,"
            "date TEXT"
            ")");
      },
    );
  }

  //Neuer Eintrag in die Datenbank
  newEintrag(Eintrag newEintrag) async {
      final db = await database;
      //get the biggest id in the table
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Eintrag");
      int id = table.first["id"];
      //insert to the table using the new id
      var raw = await db.rawInsert(
          "INSERT Into Eintrag (id,minus,amount,category,usage,date)"
              " VALUES (?,?,?,?,?,?)",
          [
            id,
            newEintrag.minus,
            newEintrag.amount,
            newEintrag.category,
            newEintrag.usage,
            newEintrag.date
          ]);
    return raw;
  }


  getClient(int id) async {
    final db = await database;
    var res = await db.query("Eintrag", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Eintrag.fromMap(res.first) : null;
  }

  //Abruf aller Listeneinträge
  Future<List<Eintrag>> getAllEintraege() async {
    final db = await database;
    var res = await db.query("Eintrag");
    List<Eintrag> list =
        res.isNotEmpty ? res.map((c) => Eintrag.fromMap(c)).toList() : [];
    return list;
  }

  //Abruf aller Einträge einer bestimmten Kategorie
  Future<List<Eintrag>> getAllEintraegeCategory(String category) async {
    final db = await database;
    var res =
        await db.query("Eintrag", where: "category = ?", whereArgs: [category]);
    List<Eintrag> list =
        res.isNotEmpty ? res.map((c) => Eintrag.fromMap(c)).toList() : [];
    return list;
  }
  //Löschen eines Eintrags
  deleteClient(int id) async {
    final db = await database;
    return db.delete("Eintrag", where: "id = ?", whereArgs: [id]);
  }

  //Löschen aller Einträge
  deleteAll() async {
    final db = await database;
   // db.rawDelete("Delete * from Eintrag");
    return db.delete("Eintrag");
  }

  //Abruf des Gesamtkontostandes
  Future<double> getTotal() async {
    final db = await database;
    double temptotal = 0;
    var result = await db.rawQuery("SELECT SUM(amount) as Total FROM Eintrag");
    temptotal = await result[0]['Total'];
    return temptotal;
  }

  //Abruf des Kontostandes für eine bestimmte Kategorie
  Future<double> getCategorySum(String category) async {
    final db = await database;
    double tempcategory = 0;
    var catResult = await db.rawQuery(
        "SELECT SUM(amount) as Total FROM Eintrag WHERE category = ?",
        [category]);
    tempcategory = await catResult[0]['Total'];
    return tempcategory;
  }

  //Abruf des Kontstandes nur mit Ausgaben
  Future<double> getMinusTotal() async {
    var now = DateFormat('MM').format(DateTime.now());
    final db = await database;
    double tempMinus = 0;
    var minusRes = await db.rawQuery(
        "SELECT SUM(amount) as Total FROM Eintrag WHERE amount < 0 AND substr(date, 4, 2) = ?",
        [now]);
    tempMinus = await minusRes[0]['Total'];
    return tempMinus;
  }
}


/* blockOrUnblock(Eintrag client) async {
    final db = await database;
    Eintrag blocked = Eintrag(
        id: client.id,
        firstName: client.firstName,
        lastName: client.lastName,
        blocked: !client.blocked);
    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }*/

/*Future<List<Eintrag>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }*/
