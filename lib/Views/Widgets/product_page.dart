import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/Constants/text_styles.dart';
import 'package:flutter_fashion/Views/Widgets/action_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatelessWidget {
  final String id;

  const ProductPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .doc(id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
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
                  Map<String, dynamic>? documentData = snapshot.data?.data();
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 24, right: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Center(
                                  child: Image.network(
                                documentData!['Image'],
                                fit: BoxFit.fitWidth,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                documentData['Category'],
                                style: TextStyle(
                                    fontFamily: "FiraSansCondensed",
                                    color: Colors.black54,
                                    fontSize: 16),
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                documentData['Name'],
                                style: Constants.boldHeading,
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rs ${documentData['Price']}",
                                style: TextStyle(
                                    fontFamily: "FiraSansCondensed",
                                    color: Color(0xFFdf861d),
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                documentData['Details'],
                                style: TextStyle(
                                    fontFamily: "FiraSansCondensed",
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height:56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFDCDCDC),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Icon(
                                        Icons.bookmark_border_rounded,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap:()async{
                                        await canLaunch(documentData['Link']) ? await launch(documentData['Link']) : throw 'Could not launch ${documentData['Link']}';
                                      },
                                      child: Container(
                                        height:56,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        child: Center(
                                          child: Text("Go to Myntra",style:Constants.regularWhiteHeading,maxLines: 2,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
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
          ActionBar(title: "ProductPage", hasBackArrow: true, hasTitle: false)
        ],
      ),
    );
  }
}
