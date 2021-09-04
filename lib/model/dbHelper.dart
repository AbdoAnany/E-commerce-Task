import 'package:abdelrahman/control/products_notifier.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Product.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  Database? _db;
  createDatabase() async {
    // _db!.delete('pr3');

    if (_db != null) return _db;
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'pr3.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      await db.execute('CREATE TABLE pr3 ('
          'id INTEGER PRIMARY KEY,'
          'title varchar(100),'
          'price INTEGER ,'
          'priceBefore INTEGER,'
          'date  varchar(100) ,'
          'barcode  varchar(100),'
          'description  varchar(500),'
          'image  varchar(500),'
          'type  varchar(100),'
          'category  varchar(100),'
          'rating INTEGER,'
          'isPopular INTEGER, '
          'isFavourite INTEGER '
          ')');
    });
    return _db;
  }

  Future<int> createDateItem(Product productItem) async {
    Database db = await createDatabase();
    print(db.insert('pr3', productItem.toMaps()));
    return db.insert('pr3', productItem.toMaps());
  }

  Future<int> updateDateItem(Product productItem) async {
    Database db = await createDatabase();
    print(productItem.isPopular);

    int x = await db.update('pr3', productItem.toMaps(),
        where: 'id = ?', whereArgs: [productItem.id]);
    return x;
  }

  Future<List<dynamic>> allDateItem() async {
    Database db = await createDatabase();
    List<Product> p = [];

    return db.query('pr3');
  }

  countItem() async {
    Database db = await createDatabase();
    int? c =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM pr3'));
    print(c);
    return c;
  }

  deleteDateItem(id) async {
    Database db = await createDatabase();
    return db.delete('pr3', where: 'id = ?', whereArgs: [id]);
  }
}
