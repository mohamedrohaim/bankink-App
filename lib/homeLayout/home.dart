import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/constant.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../profileAndTrancfeerMony/UserProfile.dart';

class HomeScrean extends StatelessWidget {
    HomeScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BankCubit cubit=BankCubit.get(context);
    return BlocConsumer<BankCubit,BankStates>(

      listener: (context,state){
        if(state is sendMonySuccess)
          {
            cubit.CreateDataBase();
          }
      },
      builder: (context,state)
      {
        return Scaffold(

          appBar: AppBar(
            title: const Text('XMR BANK',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            // elevation: 30.0,
            leading: IconButton(
              icon: const Icon(Icons.menu,color: Colors.black,),
              onPressed: () {

              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active,color: Colors.black,),
                onPressed: () {

                },
              ),
            ],
            backgroundColor: Colors.white,


          ),
          body:  ConditionalBuilder(
            condition: Users != null,
            builder: (context)=>Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15,left:16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Good Morning',style: GoogleFonts.inter(fontSize: 16.0,fontWeight: FontWeight.w500,color: Colors.black),textAlign: TextAlign.start,),
                      Text('Mohamed Rohaim',style: GoogleFonts.inter(fontSize: 21.0,fontWeight: FontWeight.bold,color: Colors.black),),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
                  height:199 ,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Stack(
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.orange)),
                            const SizedBox(height: 5.0,),
                            Text('\$ 25,564,00 USD',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w500,color: Colors.white)),
                            const SizedBox(height: 10.0,),
                            Text('Card Number',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                            const SizedBox(height: 5.0,),
                            Expanded(child: Center(child: Text('4242 **** **** 4242',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w500,color: Colors.white)))),
                            Row(
                              children: [
                                Expanded(child: Text('12/04 ',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white))),
                                Text('VSA',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.orange)),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),


                ),
                Row(children: const [
                ],),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(children: [

                      Row(
                        children:  [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20.0),
                            child: Text('Users',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),),

                          ),

                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0,top: 20.0),
                        height: 150,
                        width: double.infinity,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context,index)=>const SizedBox(width: 10.0,),
                          itemBuilder:(context,index,){
                            return  InkWell(
                                onTap: ()
                                {
                                  userId= Users[index]['id'];
                                 print(userId);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfile(
                                    name: Users[index]['name'],
                                    email: Users[index]['email'],
                                    balance: Users[index]['balance'],

                                  )));
                                },
                                child: buildUsersWidget(context,Users[index]));
                          },
                          itemCount: Users.length,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 20.0,),
                        child: Row(
                          children:  [
                            Row(
                              children:  [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 20.0),
                                  child: Text('Total sent',style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),),

                                ),

                              ],
                            ),


                          ],
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 10.0),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>buildTotalSent(context,Users[index]),
                          separatorBuilder:(context, index) =>const SizedBox(height: 5.0,), itemCount: Users.length),
                    ],),
                  ),
                ),









              ],
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 20.0,
            onPressed: () {},
            child: const Icon(Icons.call,size: 40.0,color: Colors.white,),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.white,
          //create button navigation bar
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.black,),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active,color: Colors.black,),
                label: "Notification",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.black,),
                label: "Users",
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (index){
              if (kDebugMode) {
                print(index);
              }
            },
          ),


        );
      },
    );
  }
}



Widget buildUsersWidget(BuildContext context,Map model) =>Container(
  height: 100,
  width: 90,
  child: Column(
        children:  [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331256__340.png'),
            radius: 40.0,
          ),
          SizedBox(height: 5.0,),
          Text('${model['name']}', style: TextStyle(fontSize: 10.0,color: Colors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,),



        ],

      )





);

Widget buildTotalSent(BuildContext context,Map model)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children:[
      const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331256__340.png'),
        radius: 35.0,
      ),
      const SizedBox(width: 5.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text('${model['name']}',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.w300,color: Colors.black),),
            Text('${model['email']}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300,color: Colors.blueGrey),),
          ],
        ),
      ),
       Text('${model['balance']}',style: const TextStyle(fontSize: 23.0,fontWeight: FontWeight.w300,color: Colors.orange),),

    ],
  ),
);


