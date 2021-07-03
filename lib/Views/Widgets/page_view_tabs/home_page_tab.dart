import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/Constants/text_styles.dart';
import 'package:flutter_fashion/Views/Widgets/action_bar.dart';
import 'package:flutter_fashion/Views/Widgets/product_list.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Products").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: Constants.regularDarkText,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top:90.0),
                  child: ListView(
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      return ProductCard(
                        product_id: document.id,
                        imageUrl: data['Image'],
                        name: data['Name'],
                        price: data['Price'],
                      );
                    }).toList(),
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xFFFF1E00)),
                  ),
                ),
              );
            }),
        ActionBar(title: "HomePage", hasBackArrow: false, hasTitle: true)
      ],
    );
  }
}
