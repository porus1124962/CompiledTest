import 'dart:async';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:karachi_hills_project/Screen/views/agent/agent_bottombar.dart';
import 'package:karachi_hills_project/Screen/views/agent/agent_submitFormDetails.dart';
import 'package:karachi_hills_project/Services/baseService.dart';
import 'package:karachi_hills_project/Utils/appColors.dart';
import 'package:karachi_hills_project/provider/agent_register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/remaining_count_Provider.dart';
import '../selectedView/listItemAgent.dart';
import '../selectedView/listOfPlots_provider.dart';
import 'agent_submitDetailsView.dart';

class RegList extends StatefulWidget {
  @override
  _RegListState createState() => _RegListState();
}

class _RegListState extends State<RegList> {
  TextEditingController searchController = TextEditingController();
  late List<GDPData> _chartData;
  bool isLoading = false, loading = true;
  Timer? _timer;
  late int page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool hasMoreData = true;
  String query = "";
  List itemList = [];
  List selectedList = [];
  List appDetailsList = [];
  List appIdList = [];
  int pageNumberAgent = 1;
  String? roleID;
  final controller = ScrollController();
  var scaffoldKey = GlobalKey<ScaffoldState>();


  void searchClientRegion(String query){
    BaseService().agentRegisterForms(context, 1, query);
  }


  void searchClient(String query) {
    var user;
    var getMembershipFormsProvider =
        Provider.of<GetRegistrationProvider>(context, listen: false);
    print(query);

    if (getMembershipFormsProvider.registerFormModel == null) {
      user =
          getMembershipFormsProvider.registerFormModel!.data!.items!.where((u) {
        var userName = u.name!.toLowerCase();
        var userStatus = u.status!.toLowerCase();
        var userCnic = u.cnic!.toLowerCase();
        var searchLower = query.toLowerCase();

        return userName.contains(searchLower) ||
            userStatus.contains(searchLower) ||
            userCnic.contains(searchLower);
      }).toList();
      setState(() {
        this.query = query;
        this.appDetailsList = user;
        itemList = [];
        List.generate(appDetailsList.length, (index) {
          itemList!.add(Item(
            applicationRequestId: appDetailsList[index].applicationRequestId,
            cnic: appDetailsList[index].cnic,
            dateCreated: appDetailsList[index].createdAt,
            mobile: appDetailsList[index].phone,
            name: appDetailsList[index].name,
            status: appDetailsList[index].status,
            id: appDetailsList![index].id,
            updatedBy: appDetailsList![index].updatedBy,
            roleID: roleID,
            updatedByUser_FullName: appDetailsList![index].updatedByUser == null
                ? "empty"
                : appDetailsList![index].updatedByUser.fullName,
            createdByUser_FullName:
                appDetailsList![index].createdByUser!.fullName,
          ));
        });
      });
    } else {
      user =
          getMembershipFormsProvider.registerFormModel!.data!.items!.where((u) {
        var userStatus = u.status!.toLowerCase();
        var searchLower = query.toLowerCase();
        var userCnic;
        if (u.cnic == null) {
          userCnic = "";
        } else {
          userCnic = u.cnic!.toLowerCase();
        }
        return userStatus.contains(searchLower) ||
            userCnic.contains(searchLower);
      }).toList();
      setState(() {
        this.query = query;
        this.appDetailsList = user;
        itemList = [];
        List.generate(appDetailsList.length, (index) {
          itemList!.add(Item(
            applicationRequestId: appDetailsList[index].applicationRequestId,
            cnic: appDetailsList[index].cnic,
            dateCreated: appDetailsList[index].createdAt,
            mobile: appDetailsList[index].phone,
            name: appDetailsList[index].name,
            status: appDetailsList[index].status,
            id: appDetailsList![index].id,
            updatedBy: appDetailsList![index].updatedBy,
            roleID: roleID,
            updatedByUser_FullName: appDetailsList![index].updatedByUser == null
                ? "empty"
                : appDetailsList![index].updatedByUser.fullName,
            createdByUser_FullName:
                appDetailsList![index].createdByUser!.fullName,
          ));
        });
      });
    }
  }

  // Future<void> searchClient(String query) async {
  //
  //   var user;
  //   // setState(() {
  //   //   page = 1;
  //   // });
  //
  //     await BaseService().agentRegisterForms(context, 1, query);
  //     var getMembershipFormsProvider =
  //     Provider.of<GetRegistrationProvider>(context, listen: false);
  //     print(query);
  //     user = getMembershipFormsProvider.registerFormModel!.data!.items!;
  //     setState(() {
  //       this.query = query;
  //       this.appDetailsList = user;
  //       print("serached List ${appDetailsList[0].status}");
  //       itemList= [];
  //       List.generate(appDetailsList.length, (index) {
  //         itemList!.add(Item(
  //           applicationRequestId: appDetailsList[index].applicationRequestId,
  //           cnic: appDetailsList[index].cnic,
  //           dateCreated: appDetailsList[index].createdAt,
  //           mobile: appDetailsList[index].phone,
  //           name: appDetailsList[index].name,
  //           status: appDetailsList[index].status,
  //           id: appDetailsList![index].id,
  //           updatedBy: appDetailsList![index].updatedBy,
  //           roleID: roleID,
  //           updatedByUser_FullName: appDetailsList![index].updatedByUser == null? "empty" : appDetailsList![index].updatedByUser.fullName,
  //           createdByUser_FullName: appDetailsList![index].createdByUser!.fullName,
  //         ));
  //       });
  //     });
  //
  //   // if (getMembershipFormsProvider.registerFormModel!.data!.items!.length == 0 ||
  //   //     getMembershipFormsProvider.registerFormModel!.data!.meta!.totalItems! <= 15) {
  //   //   setState(() {
  //   //     hasMoreData = false;
  //   //   });
  //   //   return;
  //   // }
  //
  //   // else {
  //   //   controller.addListener(() {
  //   //     setState(() {
  //   //       hasMoreData = true;
  //   //       _hasNextPage = true;
  //   //     });
  //   //     if (controller.position.maxScrollExtent == controller.offset) {
  //   //    //   loadMore();
  //   //     }
  //   //   });
  //   // }
  //
  // }

  @override
  void initState()  {
    var getMembershipFormsProvider =
        Provider.of<GetRegistrationProvider>(context, listen: false);

    getMembershipFormsProvider.resetAgentRegistrationList();

    BaseService().formCount(context);
    BaseService().agentRegisterForms(context, 1, "");
    setBool();
    var remainingFormSubmittedOnCnicProvider =
        Provider.of<RemainingFormSubmittedOnCnicProvider>(context,
            listen: false);
    var listOfPlotsProvider =
        Provider.of<ListOfPlotsProvider>(context, listen: false);
    listOfPlotsProvider.resetListOfPlotIds();
    listOfPlotsProvider.resetListOfPlotIdsSingleForm();
    remainingFormSubmittedOnCnicProvider.restRemainigFormCount();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          pageNumberAgent++;
        });
        //     loadMore();

        BaseService().agentRegisterForms(context, pageNumberAgent, "");
      }
    });

    // if (getMembershipFormsProvider.registerFormModel!.data!.items!.length == 0 ||
    //     getMembershipFormsProvider.registerFormModel!.data!.meta!.totalItems! <= 15) {
    //   setState(() {
    //     hasMoreData = false;
    //   });
    //   return;
    // }
    //
    // else {
    //
    // }

    //_chartData = getChartData(context);
    super.initState();
  }

  setBool() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getMembershipFormsProvider =
        Provider.of<GetRegistrationProvider>(context, listen: false);

    await Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        roleID = prefs.getString('roleId')!;
        appDetailsList = getMembershipFormsProvider.agentRegistrationList;

        // List.generate(appDetailsList.length, (index) {
        //   itemList!.add(Item(
        //     applicationRequestId: appDetailsList[index].applicationRequestId,
        //     cnic: appDetailsList[index].cnic,
        //     dateCreated: appDetailsList[index].createdAt,
        //     mobile: appDetailsList[index].phone,
        //     name: appDetailsList[index].name,
        //     status: appDetailsList[index].status,
        //     id: appDetailsList![index].id,
        //     updatedBy: appDetailsList![index].updatedBy,
        //     roleID: roleID,
        //     updatedByUser_FullName: appDetailsList![index].updatedByUser == null
        //         ? "empty"
        //         : appDetailsList![index].updatedByUser.fullName,
        //     createdByUser_FullName:
        //         appDetailsList![index].createdByUser!.fullName,
        //   ));
        // });
        _isFirstLoadRunning = false;
        loading = false;
      });
    });
  }

  // loadMore() async {
  //   var getMembershipFormsProvider =
  //       Provider.of<GetRegistrationProvider>(context, listen: false);
  //   if (isLoading || hasMoreData == false) return;
  //   List tempList = [];
  //   // isLoading = true;
  //   if (_hasNextPage == true &&
  //       hasMoreData == true &&
  //       _isFirstLoadRunning == false &&
  //       _isLoadMoreRunning == false) {
  //
  //     setState(() {
  //       _isLoadMoreRunning = true; // Display a progress indicator at the bottom
  //     });
  //
  //     //  getMembershipFormsProvider.restRegisterFormsProvider();
  //     page += 1;
  //     print(page);
  //     int limit = 15;
  //
  //     await BaseService().agentRegisterForms(context, page, query);
  //     tempList = getMembershipFormsProvider.registerFormModel!.data!.items!;
  //
  //     setState(() {
  //       if (tempList.length < limit || itemList.length < limit) {
  //         setState(() {
  //           isLoading = false;
  //           hasMoreData = false;
  //         });
  //       }
  //       setState(() {
  //          // appDetailsList = [...appDetailsList, ...tempList];
  //
  //
  //         // for (int i = 0; i < tempList.length; i++) {
  //         //   itemList.add(
  //         //       Item(
  //         //         applicationRequestId: tempList[i].applicationRequestId,
  //         //         cnic: tempList[i].cnic,
  //         //         dateCreated: tempList[i].createdAt,
  //         //         mobile: tempList[i].phone,
  //         //         name: tempList[i].name,
  //         //         status: tempList[i].status,
  //         //         id: tempList![i].id,
  //         //         updatedBy: tempList![i].updatedBy,
  //         //         roleID: roleID,
  //         //         updatedByUser_FullName: tempList![i].updatedByUser == null? "empty" : tempList![i].updatedByUser.fullName,
  //         //         createdByUser_FullName: tempList![i].createdByUser!.fullName,
  //         //       )
  //         //   );
  //         // }
  //       });
  //
  //       print(tempList.length);
  //       print(appDetailsList.length);
  //       //appDetailsList..addAll(tempList);
  //     });
  //   }
  //
  //   else {
  //     // This means there is no more data
  //     // and therefore, we will not send another GET request
  //     setState(() {
  //       _hasNextPage = false;
  //      // hasMoreData = false;
  //     });
  //   }
  //
  //   setState(() {
  //     _isLoadMoreRunning = false;
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var agentRegistrationsProvider =
        Provider.of<GetRegistrationProvider>(context, listen: false);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "btn5",
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => HomePage()));
      //   },
      //   child: Container(
      //       height: h * 1,
      //       width: w * 1,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: RadialGradient(
      //           center: const Alignment(0.0, 0.0),
      //           radius: 0.4,
      //           colors: [Colors.teal, AppColors.Secondary_COLOR],
      //         ),
      //       ),
      //       child: Icon(Icons.home, color: Colors.white)),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 5,
      //   shape: CircularNotchedRectangle(),
      //   color: Colors.white,
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     type: BottomNavigationBarType.fixed,
      //     elevation: 0,
      //     unselectedItemColor: Colors.grey,
      //     selectedItemColor: AppColors.Secondary_COLOR,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //           child: Icon(Icons.list, color: AppColors.GREYTEXT_COLOR),
      //           onTap: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => AppList()));
      //           },
      //         ),
      //         title: Text(
      //           "Registration",
      //           style: TextStyle(color: AppColors.GREYTEXT_COLOR),
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //             child: Icon(Icons.wallet_membership,
      //                 color: AppColors.Secondary_COLOR),
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => RegistrationList()));
      //             }),
      //         title: Text(
      //           "Registration",
      //           style: TextStyle(color: AppColors.Secondary_COLOR),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Stack(
        children: [
          Container(
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage("assets/image/marble.jpg")),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: h * .3,
                    width: w * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ExactAssetImage("assets/image/marble.jpg")),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      height: h * .3,
                      width: w * 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h * .05),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: w * .3,
                                  height: h * .17,
                                ),
                                Column(
                                  children: [
                                    Text("Total",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    Text("${appDetailsList.length}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                                appIdList.length != 0
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AgentSubmitFormDetails(
                                                        applicationIds:
                                                            appIdList,
                                                      )));
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 40,
                                          child: Center(
                                              child: Text(
                                                  "Proceed ${appIdList.length}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .Secondary_COLOR,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: AppColors.PRIMARY_COLOR),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 1,
                                      )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: w * 0.8,
                                height: h * 0.05,
                                child: TextFormField(
                                    onChanged: searchClientRegion,
                                    cursorColor: AppColors.PRIMARY_COLOR,
                                    controller: searchController,
                                    style: TextStyle(
                                        color: AppColors.PRIMARY_COLOR),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppColors.PRIMARY_COLOR,
                                      ),
                                      labelText: "Search",
                                      labelStyle: TextStyle(
                                        color: AppColors.PRIMARY_COLOR,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: AppColors.PRIMARY_COLOR,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: AppColors.PRIMARY_COLOR,
                                          width: 1.0,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      width: w * 1,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Registration List",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.PRIMARY_COLOR),
                              ),
                            ),
                            SizedBox(
                              width: w * .08,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child:
                        // loading == true
                        //     ? Center(
                        //         child: Container(child: CircularProgressIndicator()),
                        //       )
                        //     :

                        Consumer<GetRegistrationProvider>(
                      builder: (context, getRegistrationProvider, child) =>
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: agentRegistrationsProvider.registerFormModel ==
                                null
                            ? Center(
                          child: Container(child: CircularProgressIndicator()),
                        )
                            :
                        ListView.builder(
                                addAutomaticKeepAlives: true,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                controller: controller,
                                itemCount: getRegistrationProvider.agentRegistrationList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index < getRegistrationProvider.agentRegistrationList.length) {
                                    String dateEdit = getRegistrationProvider.agentRegistrationList[index]
                                        .createdAt!
                                        .split("T")[0];
                                    DateTime tempDate =
                                        new DateFormat("yyyy-MM-dd")
                                            .parse(dateEdit);
                                    var formattedDate =
                                        DateFormat.yMMMEd().format(tempDate);
                                    return ListItemAgent(
                                      idPassedId: (value) {
                                        if (appIdList.contains(value)) {
                                          appIdList.remove(value);
                                          print(appIdList.toString());
                                        } else {
                                          appIdList.add(value);
                                          print(appIdList.toString());
                                        }
                                      },
                                      isSelected: (bool value) {
                                        setState(() {
                                          if (value) {
                                            selectedList!.add([index]);
                                          } else {
                                            selectedList!
                                                .remove(itemList![index]);
                                          }
                                        });
                                      },
                                      // key: Key(itemList![index].appId.toString()),
                                      item: Item(
                                        applicationRequestId: getRegistrationProvider.agentRegistrationList[index].applicationRequestId,
                                        cnic: getRegistrationProvider.agentRegistrationList[index].cnic,
                                        dateCreated: getRegistrationProvider.agentRegistrationList[index].createdAt,
                                        mobile: getRegistrationProvider.agentRegistrationList[index].phone,
                                        name: getRegistrationProvider.agentRegistrationList[index].name,
                                        status: getRegistrationProvider.agentRegistrationList[index].status,
                                        id: getRegistrationProvider.agentRegistrationList![index].id,
                                        updatedBy: getRegistrationProvider.agentRegistrationList![index].updatedBy,
                                        roleID: roleID,
                                        updatedByUser_FullName: getRegistrationProvider.agentRegistrationList![index].updatedByUser == null
                                            ? "empty"
                                            : getRegistrationProvider.agentRegistrationList![index].updatedByUser.fullName,
                                        createdByUser_FullName:
                                        getRegistrationProvider.agentRegistrationList![index].createdByUser!.fullName,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 32),
                                      child: Center(
                                          child:
                                              // hasMoreData
                                              //     ? CircularProgressIndicator()
                                              //   :
                                              Text('No more data to load!')),
                                    );
                                  }
                                },
                              ),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/*List<GDPData> getChartData(context) {
  var utilProvider = Provider.of<UtilProvider>(context, listen: false);
  final List<GDPData> charData = [
    GDPData(continent: "total", gdp: utilProvider.membershipFormCount!),
    GDPData(continent: "avail", gdp: utilProvider.counter!),
  ];
  return charData;
}*/

class GDPData {
  GDPData({required this.continent, required this.gdp});

  final String continent;
  final int gdp;
}
