import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/Widgets/product_page.dart';

class ProductCard extends StatelessWidget {
  final String product_id;
  final String imageUrl;
  final String name;
  final String price;
  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.product_id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      id: product_id,
                    )));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Stack(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                      child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF171820),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: "FiraSansCondensed",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Rs ${price}",
                        style: TextStyle(
                          fontFamily: "FiraSansCondensed",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFdf861d),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
