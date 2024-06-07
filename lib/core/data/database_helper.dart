import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import 'model/image_gender_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE gender(
        imageID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT,
        accuracy DOUBLE,
        prediction VARCHAR,
        date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE attractiveness(
        imageID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT,
        accuracy DOUBLE,
        prediction VARCHAR,
        insight TEXT,
        date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE emotion(
        imageID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT,    
        accuracy DOUBLE,
        prediction VARCHAR,
        date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE skin(
        imageID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT,    
        accuracy DOUBLE,
        prediction VARCHAR,
        date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE attractivenessInsight(
        insightID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        insight TEXT,
        ugly INTEGER DEFAULT 0
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'testttttttt.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> insertInsightsFromJson(String filePath) async {
    final String data = await rootBundle.loadString(filePath);
    final insights = json.decode(data);

    final db = await SQLHelper.db();

    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM attractivenessInsight'));
    if (count == 0) {
      insights.forEach((insight) async {
        final Map<String, dynamic> data = {
          'insight': insight['insight'],
          'ugly': insight['ugly'] == 1 ? 1 : 0,
        };
        await db.insert('attractivenessInsight', data,
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getInsights() async {
    final db = await SQLHelper.db();
    return db.rawQuery('SELECT * FROM attractivenessInsight');
  }

  // static Future<void> deleteAllInsights() async {
  //   final db = await SQLHelper.db();
  //   await db.delete('attractivenessInsight');
  // }

  static Future<Map<String, dynamic>> getRandomBeautifulInsight() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> insights =
        await db.rawQuery('SELECT * FROM attractivenessInsight WHERE ugly = 0');

    final random = Random();
    final randomIndex = random.nextInt(insights.length);
    return insights[randomIndex];
  }

  static Future<Map<String, dynamic>> getRandomUglyInsight() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> insights =
        await db.rawQuery('SELECT * FROM attractivenessInsight WHERE ugly = 1');

    final random = Random();
    final randomIndex = random.nextInt(insights.length);
    return insights[randomIndex];
  }

  static Future<List<Map<String, dynamic>>> getAttractiveness() async {
    final db = await SQLHelper.db();
    return db.rawQuery('SELECT * FROM attractiveness');
  }

  static Future<List<Map<String, dynamic>>> getAllDataOrderedByDate() async {
    final db = await SQLHelper.db();
    return db.rawQuery('''
    SELECT * FROM (
      SELECT imageID, image, accuracy, prediction, null as insight, date_created FROM gender
      UNION ALL
      SELECT imageID, image, accuracy, prediction, null as insight, date_created FROM emotion
      UNION ALL
      SELECT imageID, image, accuracy, prediction, null as insight, date_created FROM skin
      UNION ALL
      SELECT imageID, image, accuracy, prediction, insight, date_created FROM attractiveness
    )
    ORDER BY date_created ASC
  ''');
  }

  Future<void> removeImage(ImageModel image, String type) async {
    final db = await SQLHelper.db();
    final tableName = _getTableName(type);
    await db.delete(
      tableName,
      where: 'imageID = ?',
      whereArgs: [image.imageID],
    );
  }

  String _getTableName(String type) {
    if (type == "gender") {
      return 'gender';
    } else if (type == "emotion") {
      return 'emotion';
    } else if (type == "rate") {
      return 'attractiveness';
    }
    throw Exception('Invalid image type');
  }

// ********************************************
  static Future<void> deleteAllImages() async {
    final db = await SQLHelper.db();
    await db.delete('gender');
    await db.delete('emotion');
    await db.delete('skin');
    await db.delete('attractiveness');
  }
// ********************************************

  static Future<int> insertGenderImage(
      String image, double accuracy, String prediction) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'accuracy': accuracy,
      'prediction': prediction,
    };
    final res = await db.insert('gender', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return res;
  }

  static Future<int> insertEmotionImage(
      String image, double accuracy, String prediction) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'accuracy': accuracy,
      'prediction': prediction,
    };
    final res = await db.insert('emotion', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return res;
  }

  static Future<int> insertSkinImage(
      String image, double accuracy, String prediction) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'accuracy': accuracy,
      'prediction': prediction,
    };
    final res = await db.insert('skin', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return res;
  }

  static Future<int> insertRateImage(
      String image, double accuracy, String prediction, String insight) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'accuracy': accuracy,
      'prediction': prediction,
      'insight': insight,
    };
    final res = await db.insert('attractiveness', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return res;
  }
}
