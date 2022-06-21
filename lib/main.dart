import 'package:bank/cubit/cubit.dart';
import 'package:bank/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/MyBlocObserver.dart';
import 'homeLayout/home.dart';

void main()async {
  BlocOverrides.runZoned(
        ()async {
          runApp(const MyApp());
        },
    blocObserver: MyBlocObserver() ,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create:(context)=> BankCubit()..CreateDataBase(),
    child:BlocConsumer<BankCubit,BankStates>(
      listener: (context, state) {},
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home:  HomeScrean(),
        );
      },
    ),
    );
  }
}

