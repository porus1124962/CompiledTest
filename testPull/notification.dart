import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../services/baseFunctions.dart';
import '../../../Utils/appColors.dart';
import 'NotificationModel.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({Key? key}) : super(key: key);

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {

  var fetchData;
  void initState() {
    super.initState();
    fetchData = BaseServiceClass().getNotification(context);

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("FCM here"+token.toString());
    });

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print('getInitialMessage data: ${message}');
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');

    });



  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Notification"),centerTitle: true,backgroundColor: AppColors.PRIMARY_COLOR),
      body:FutureBuilder<NotificationModel>(
        future:fetchData,
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("Some Error Occurred!"),
                );
              }else{
                return    ListView.builder(
                    itemCount: snapshot.data!.data!.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Card(
                           color:  AppColors.WHITE_COLOR,
                          elevation: 12,

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:  AppColors.WHITE_COLOR,
                            ),


                            width: w*1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${snapshot.data!.data!.items![index].shortTitle}",style: TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: h*.01,
                                        ),
                                     //   Text("${snapshot.data!.data!.items![index].message} kjdhf sjdhdjdc shdshfjd sfhdjfhjfn dsn fdjskdfn dckdnk ",style: TextStyle(fontSize: 15,color: AppColors.WHITE_COLOR,)),

                                        SizedBox(
                                          width: 200,
                                          child: AutoSizeText(
                                            '${snapshot.data!.data!.items![index].message}',
                                            style: TextStyle(fontSize: 16,color: Colors.black),
                                            maxLines: 2,
                                          ),
                                        ),

                                      ],
                                    ),

                                    Padding(
                                      padding:  EdgeInsets.all(12),
                                      child: Text("${snapshot.data!.data!.items![index].id}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:snapshot.data!.data!.items![index].isReaded == false ? AppColors.Secondary_COLOR:AppColors.PRIMARY_COLOR)),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    });
              }
          }

        },

      ),
    );
  }
}

