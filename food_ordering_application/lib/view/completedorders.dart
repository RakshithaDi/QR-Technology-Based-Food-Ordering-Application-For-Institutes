import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:food_ordering_application/model/constant.dart';
import 'account.dart';
import 'orderdetails.dart';

class completedOrders extends StatefulWidget {
  const completedOrders({Key key}) : super(key: key);

  @override
  _completedOrdersState createState() => _completedOrdersState();
}

class _completedOrdersState extends State<completedOrders> {
  String userEmail;
  int pendingOrderslength;
  int collectedOrderslength;
  @override
  void initState() {
    super.initState();

    getUserMail();
    CheckDeliveredOrders();
  }

  void getUserMail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  void CheckDeliveredOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('Email', isEqualTo: userEmail)
        .where('Status', isEqualTo: 'Collected')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.size == 0) {
        setState(() {
          collectedOrderslength = 0;
        });
      } else {
        setState(() {
          collectedOrderslength = documentSnapshot.size;
        });
      }
      print('Collected Orders length:${documentSnapshot.size}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            collectedOrderslength != 0
                ? Container(
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('orders')
                          .where('Email', isEqualTo: userEmail)
                          .where('Status', isEqualTo: 'Collected')
                          .orderBy('TimeStamp', descending: true)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        //
                        // if (snapshot.connectionState == ConnectionState.waiting ||
                        //     !snapshot.hasData) {
                        //   return CircularProgressIndicator();
                        // }

                        if (snapshot.hasData) {
                          print('has data in orders');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    QueryDocumentSnapshot orders =
                                        snapshot.data.docs[index];
                                    String formatedDate;

                                    Timestamp timestamp = orders['TimeStamp'];
                                    DateTime dateTime = timestamp.toDate();
                                    String formatDate = DateFormat.yMMMd()
                                        .add_jm()
                                        .format(dateTime);
                                    formatedDate = formatDate;

                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 2,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      EachOrders(
                                                          orders['OrderId']),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2,
                                                                    right: 10,
                                                                    top: 2,
                                                                    bottom: 2),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .border_color,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 14,
                                                                ),
                                                                Text(
                                                                  '${orders['OrderId']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          color: Colors.black,
                                                        ),
                                                        // Expanded(
                                                        //   flex: 3,
                                                        //   child:
                                                        //       Container(
                                                        //     child: orders['Status'] ==
                                                        //             'New'
                                                        //         ? Text(
                                                        //             "Status : Pending",
                                                        //             textAlign: TextAlign.right,
                                                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                        //           )
                                                        //         : Text(
                                                        //             "Status : ${orders['Status']}",
                                                        //             textAlign: TextAlign.right,
                                                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                        //           ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          left: 5,
                                                          top: 7,
                                                        ),
                                                        child: Text(
                                                          formatedDate,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .grey[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  top: 7,
                                                                  bottom: 5),
                                                          child: Text(
                                                            'Rs.${orders['Amount']}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey[600],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child:
                                                      //       Container(
                                                      //     alignment:
                                                      //         Alignment
                                                      //             .topRight,
                                                      //     child:
                                                      //         SizedBox(
                                                      //       height: 40,
                                                      //       width: 100,
                                                      //       child: Card(
                                                      //         elevation:
                                                      //             4,
                                                      //         color:
                                                      //             titleColor,
                                                      //         child:
                                                      //             InkWell(
                                                      //           onTap:
                                                      //               () {
                                                      //             String
                                                      //                 orderId =
                                                      //                 orders['OrderId'];
                                                      //             showAlertDialog(
                                                      //                 context,
                                                      //                 orderId);
                                                      //           },
                                                      //           child:
                                                      //               Center(
                                                      //             child:
                                                      //                 Text(
                                                      //               'Collected',
                                                      //               style:
                                                      //                   TextStyle(color: Colors.white),
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }

                        return Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: titleColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Icon(
                          Icons.downloading_rounded,
                          size: 100,
                          color: titleColor,
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'No completed Orders yet!',
                              style: TextStyle(fontSize: 16, color: titleColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
