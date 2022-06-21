
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import '../component/constant.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../homeLayout/home.dart';
class userProfile extends StatelessWidget {
 // const userProfile({Key? key}) : super(key: key);
   final _formKey = GlobalKey<FormState>();   /// just  define _formkey with static final
   final amountController=TextEditingController() ;

   String? name;
    String? email;
    int balance;


    userProfile({Key? key,required this.name,required this.email,required this.balance}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BankCubit cubit=BankCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body:BlocConsumer<BankCubit,BankStates>(
        listener: (context,state){
          if(state is sendMonySuccess)
          {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScrean()));
          }

        },
        builder: (context,state){
          return  Center(
            child:Container(
              height:2000,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: const Center(
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331256__340.png'),
                          radius: 50.0,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$name",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.black),),
                        const SizedBox(height: 10.0,),
                        Text("$email",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w500,color: Colors.blueGrey),),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Balance : ",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w500,color: Colors.blueGrey),),
                            Text("$balance ",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.orange),),

                          ],),
                        const SizedBox(height: 10.0,),
                        Row(children:[

                        ] ),
                        const SizedBox(height: 10.0,),

                        Center(

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              elevation: 15.0,
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text('Send money  ',style: GoogleFonts.inter(fontSize: 15.0,fontWeight: FontWeight.w800,color: Colors.white),),
                            onPressed: ()
                            {
                              print(userId);
                              showModalBottomSheet(
                                  elevation: 15.0,
                                  // shape: ,
                                  context: context,
                                  builder: (context){
                                    return Padding(

                                      padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Container(
                                        margin:  EdgeInsets.symmetric(horizontal: 10.0),
                                        height: 450,
                                        child: Column(
                                            children: [
                                              Text("Send Money :",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.black),),
                                              SizedBox(height: 10.0,),
                                              Form(
                                                key:_formKey,
                                                child: Column(
                                                  children: [
                                                    Card(
                                                      child: TextFormField(
                                                        //enabled: true,
                                                        controller:amountController ,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Colors.indigo),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          prefixIcon: const Icon(Icons.attach_money,color: Colors.indigoAccent,),
                                                          labelText: "Enter amount",
                                                          // labelStyle: const TextStyle(color: Colors.grey,),
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,

                                                        validator: (value){
                                                          if(value!.isEmpty){
                                                            return " amount can not be empty";
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    RaisedButton(onPressed: ()
                                                    {
                                                      if(_formKey.currentState!.validate())
                                                      {
                                                        print(userId);
                                                        int newBalance=int.parse(amountController.text);
                                                        int totalBalance=balance+newBalance;
                                                        print(totalBalance);
                                                        cubit.updateDataBase(userId , totalBalance);
                                                      }
                                                    },

                                                      child: Text("Send",style: GoogleFonts.inter(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),),color: Colors.orange,),

                                                  ],
                                                ),

                                              ),





                                            ]
                                        ),
                                      ),
                                    );
                                  }
                              );

                            },
                          ),
                        ),

                      ],
                    ),








                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}

