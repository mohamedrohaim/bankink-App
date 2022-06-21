
import 'package:bank/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../component/constant.dart';

class BankCubit extends Cubit<BankStates> {


  BankCubit() : super(InitialState());

  Database? database;
  static BankCubit get (BuildContext context)
  {

    return BlocProvider.of(context);
  }




  void CreateDataBase()async{
    database=await openDatabase(
      'bank.db',
      version: 1,
      onCreate: (database,version) async {
        await database.execute(
            'CREATE TABLE bank (id INTEGER PRIMARY KEY, name TEXT,email TEXT, balance INTEGER)').then((value)
        {
          emit(crateDataBaseSuccessState());
        } ).catchError((error)
        {
          emit(crateDataBaseErrorState(error));
        });

        await database.transaction((txn)async

        {
          int id1 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("mohamed rohaim","mohamed@gmail.com", 300)');
          int id2 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("ali mohamed","ahmed@gmail.com", 300)');
          int id3 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("menna ahmed","sayed@gmail.com", 300)');
          int id4 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("yasser ali","yasser@gmail.com", 300)');
          int id5 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("mohab anwar","mohab@gmail.com", 300)');
          int id6 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("anas mahmoud","anas@gmail.com", 300)');
          int id7 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("talia ali","talia@gmail.com", 300)');
          int id8 = await txn.rawInsert(
              'INSERT INTO bank(name, email,balance) VALUES("tarek abdo","tarek@gmail.com", 300)');
        } ).then((value) => {
          emit(insertDataBaseSuccessState())
        }).catchError((error) => {
          emit(insertDataBaseErrorState(error))
        });
      },
      onOpen: (database)
    {
      database.transaction((txn)async
      {
        await txn.rawQuery('SELECT * FROM bank').then((value)
        {
          Users=value;
          print(Users);
          emit(dataOpenedSuccess());
        }).catchError((error)
        {
          emit(dataOpenedErrorState(error));
        });
      });
    },);

  }
  void updateDataBase(var id,int balance)async
  {
    await database!.rawUpdate(
      'UPDATE bank SET balance =$balance WHERE id =$id',
        //'UPDATE bank SET balance=$balance WHERE id=$id'
    ).then((value)
    {

      database?.transaction((txn)async
      {
        await txn.rawQuery('SELECT * FROM bank').then((value)
        {
          Users=value;
          print(Users);
          emit(dataOpenedSuccess());
        }).catchError((error)
        {
          emit(dataOpenedErrorState(error));
        });
      });

      print(value);
      emit(sendMonySuccess());
      CreateDataBase();
    }).catchError((error)
    {
      emit(sendMonyFail());
    });

  }


}