import 'dart:developer';

import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoriteTasks = [];
  List<Map> selectedDay = [];

  void createDatabase() {
    openDatabase(
      'Taskk.db',
      version: 1,
      onCreate: (database, version) {
        log('database created');
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,startTime TEXT,endTime TEXT,Remind TEXT,isCompleted TEXT ,isFav TEXT,color TEXT)')
            .then((value) {
          log('table created');
        }).catchError((error) {
          log('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        log('database opened');
      },
    ).then((value) {
      database = value;

      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String isCompleted,
    required String isFav,
    required String color,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title,date,startTime,endTime,remind,isCompleted,isFav,color) VALUES("$title","$date","$startTime","$endTime","$remind","$isCompleted","$isFav" , "$color" )')
          .then((value) {
        log('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        log('Error When Inserting New Record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favoriteTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT *FROM Tasks').then(
      (value) {
        value.forEach((element) {
          allTasks.add(element);
          element['isFav'] == 'true' ? favoriteTasks.add(element) : null;
          element['isCompleted'] == 'true'
              ? completedTasks.add(element)
              : uncompletedTasks.add(element);
        });

        emit(AppGetDatabaseState());
      },
    );
  }

  void updateData({
    String? isCompleted,
    String? isfav,
    required int id,
  }) async {
    database.rawUpdate(
        'UPDATE Tasks SET isCompleted = ? , isfav= ? WHERE id = ? ',
        [isCompleted, isfav, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
