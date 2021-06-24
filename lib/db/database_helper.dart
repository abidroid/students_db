import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:students_db/model/student.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/students.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_student (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  course TEXT,
                  mobile TEXT, 
                  totalFee INTEGER, 
                  feePaid INTEGER )
    
    ''');
  }

  // Fetch operation: Get all Student objects from database

  Future<List<Map<String, dynamic>>> getStudentsMapList() async {
    Database db = await instance.database;
    var result = db.query('tbl_student', orderBy: null);
    return result;
  }

  // Insert operation: Insert a Student object to database

  Future<int> insertStudent(Student student) async {
    Database db = await instance.database;
    var result = db.insert('tbl_student', student.toMap());
    return result;
  }

  // Update operation: Update a Student in DB
  Future<int> updateStudent(Student student) async {
    var db = await instance.database;
    var result = db.update('tbl_student', student.toMap(),
        where: 'id=?', whereArgs: [student.id]);
    return result;
  }

  // Delete operation: Delete a Student from DB
  Future<int> deleteStudent(int id) async {
    var db = await instance.database;
    var result = db.delete('tbl_student', where: 'id=?', whereArgs: [id]);
    return result;
  }

  // Return a list of all students

  Future<List<Student>> getAllStudents() async {
    var studentsMapList = await getStudentsMapList();
    var studentsList = <Student>[];

    for (var i = 0; i < studentsMapList.length; i++) {
      Student student = Student.fromMap(studentsMapList[i]);

      studentsList.add(student);
    }

    return studentsList;
  }
}
