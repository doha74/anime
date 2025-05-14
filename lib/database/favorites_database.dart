import 'package:game_buzz/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase._init();
  static Database? _database;

  FavoritesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorites (
      id INTEGER PRIMARY KEY,
      title TEXT,
      posterPath TEXT,
      backdropPath TEXT,
      voteAverage REAL,
      voteCount INTEGER,
      releaseDate TEXT
    )
    ''');
  }

  Future<void> insertFavorite(Movie movie) async {
    final db = await instance.database;

    await db.insert(
      'favorites',
      {
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'backdropPath': movie.backdropPath,
        'voteAverage': movie.voteAverage,
        'voteCount': movie.voteCount,
        'releaseDate': movie.releaseDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Movie>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');

    return result.map((json) {
      return Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['posterPath'] as String,
        backdropPath: json['backdropPath'] as String,
        voteAverage: json['voteAverage'] as double,
        voteCount: json['voteCount'] as int,
        releaseDate: json['releaseDate'] as String,
        genreIds: (json['genreIds'] as String).split(',').map(int.parse).toList(),
      );
    }).toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await instance.database;
    final result = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
