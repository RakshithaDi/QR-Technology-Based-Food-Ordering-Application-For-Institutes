import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/searchpage.dart';
import 'package:provider/provider.dart';
import '../model/cart.dart';
import 'package:food_ordering_application/model/constant.dart';
import 'package:food_ordering_application/model/cart.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  static String id = 'cartpage';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
          backgroundColor: Sushi,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 34,
                ),
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SearchItemsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Cart.basketItems.length == 0
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Icon(
                      Icons.report_gmailerrorred_outlined,
                      size: 100,
                      color: titleColor,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'No Items in Your basket',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Add some items! ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  createSubTitle(),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        return ListView(
                          children: <Widget>[
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: Cart.basketItems.length,
                              itemBuilder: (context, index) {
                                print(index);
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 8,
                                                left: 8,
                                                top: 8,
                                                bottom: 8),
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14)),
                                                color: Colors.grey,
                                                image: DecorationImage(
                                                    image: NetworkImage(Cart
                                                        .basketItems[index]
                                                        .imgUrl))),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8, top: 4),
                                                    child: Text(
                                                      Cart.basketItems[index]
                                                          .name,
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  SizedBox(height: 6),
                                                  // Text(
                                                  //   "M",
                                                  //   style: TextStyle(
                                                  //       color: Colors.grey,
                                                  //       fontSize: 14),
                                                  // ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          'Rs.${Cart.basketItems[index].price.toString()}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Card(
                                                                child: InkWell(
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      cart.updateProduct(
                                                                          Cart.basketItems[
                                                                              index],
                                                                          Cart.basketItems[index].quantity -
                                                                              1);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                //color: Colors.grey.shade200,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5,
                                                                        right:
                                                                            10,
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  Cart
                                                                      .basketItems[
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                child: InkWell(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      cart.updateProduct(
                                                                          Cart.basketItems[
                                                                              index],
                                                                          Cart.basketItems[index].quantity +
                                                                              1);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            flex: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.only(right: 10, top: 8),
                                        child: Container(
                                          child: IconButton(
                                            icon: Container(
                                              child: Icon(
                                                Icons.close,
                                                size: 8,
                                              ),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              cart.remove(
                                                  Cart.basketItems[index]);
                                            },
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            color: Sushi),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  footer(context)
                ],
              ),
      );
    });
  }

  footer(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "Rs.${Cart.totalPrice.toString()}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CheckOut()));
            },
            color: Sushi,
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total(${Cart.basketItems.length.toString()}) Items",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 10, bottom: 5),
    );
  }

// createCartList() {
//
// }
}
