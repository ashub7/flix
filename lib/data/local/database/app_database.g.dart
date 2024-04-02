// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  FavDao? _favDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fullName` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `gender` INTEGER NOT NULL, `avatar` TEXT NOT NULL, `dob` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fav_table` (`adult` INTEGER NOT NULL, `backdropPath` TEXT, `id` INTEGER NOT NULL, `title` TEXT NOT NULL, `originalLanguage` TEXT, `originalTitle` TEXT, `overview` TEXT NOT NULL, `posterPath` TEXT, `mediaType` TEXT, `popularity` REAL, `releaseDate` TEXT, `video` INTEGER NOT NULL, `voteAverage` REAL, `voteCount` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  FavDao get favDao {
    return _favDaoInstance ??= _$FavDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'user_table',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'fullName': item.fullName,
                  'email': item.email,
                  'password': item.password,
                  'gender': item.gender,
                  'avatar': item.avatar,
                  'dob': item.dob
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  @override
  Future<List<UserModel>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM user_table',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            fullName: row['fullName'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            gender: row['gender'] as int,
            avatar: row['avatar'] as String,
            dob: row['dob'] as String));
  }

  @override
  Future<UserModel?> findPersonById(int id) async {
    return _queryAdapter.query('SELECT * FROM user_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            fullName: row['fullName'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            gender: row['gender'] as int,
            avatar: row['avatar'] as String,
            dob: row['dob'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM user_table');
  }

  @override
  Future<UserModel?> findPersonByEmail(String email) async {
    return _queryAdapter.query('SELECT * FROM user_table WHERE email = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            fullName: row['fullName'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            gender: row['gender'] as int,
            avatar: row['avatar'] as String,
            dob: row['dob'] as String),
        arguments: [email]);
  }

  @override
  Future<int> insertUser(UserModel userModel) {
    return _userModelInsertionAdapter.insertAndReturnId(
        userModel, OnConflictStrategy.replace);
  }
}

class _$FavDao extends FavDao {
  _$FavDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favMovieModelInsertionAdapter = InsertionAdapter(
            database,
            'fav_table',
            (FavMovieModel item) => <String, Object?>{
                  'adult': item.adult ? 1 : 0,
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'title': item.title,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'mediaType': item.mediaType,
                  'popularity': item.popularity,
                  'releaseDate': item.releaseDate,
                  'video': item.video ? 1 : 0,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavMovieModel> _favMovieModelInsertionAdapter;

  @override
  Future<List<FavMovieModel>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM fav_table',
        mapper: (Map<String, Object?> row) => FavMovieModel(
            adult: (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int,
            title: row['title'] as String,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String?,
            mediaType: row['mediaType'] as String?,
            popularity: row['popularity'] as double?,
            releaseDate: row['releaseDate'] as String?,
            video: (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<FavMovieModel?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM fav_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FavMovieModel(
            adult: (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int,
            title: row['title'] as String,
            originalLanguage: row['originalLanguage'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String?,
            mediaType: row['mediaType'] as String?,
            popularity: row['popularity'] as double?,
            releaseDate: row['releaseDate'] as String?,
            video: (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM fav_table WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> addToFavorites(FavMovieModel favMovieModel) {
    return _favMovieModelInsertionAdapter.insertAndReturnId(
        favMovieModel, OnConflictStrategy.replace);
  }
}
