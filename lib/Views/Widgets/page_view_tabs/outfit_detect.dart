import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/Widgets/action_bar.dart';
import 'package:flutter_fashion/Views/search_results.dart';
import 'package:tflite/tflite.dart';

class OutfitDetect extends StatefulWidget {
  final String gender;
  final File img;
  const OutfitDetect({Key? key, required this.gender, required this.img}) : super(key: key);

  @override
  _OutfitDetectState createState() => _OutfitDetectState();
}

class _OutfitDetectState extends State<OutfitDetect> {
  bool _loading = true;
  late List _output=[];

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
    classifyImage(widget.img);
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    //this function runs the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 10, //the amount of categories our neural network can predict
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
        model: 'assets/outfit_model.tflite', labels: 'assets/outfit_labels.txt');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: _loading == true
                          ? null //show nothing if no picture selected
                          : Container(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  widget.img,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            if (_output == null)
                              Container()
                            else
                              InkWell(
                                onTap:(){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchPage(
                                            outfit: '${_output[0]['label']}',
                                            gender:'${widget.gender}'
                                          )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 17),
                                  width: MediaQuery.of(context).size.width -
                                      200,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text(
                                      '${_output[0]['label']} ${widget.gender}',
                                      style: TextStyle(
                                        fontFamily: "FiraSansCondensed",
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  child: ActionBar(
                    title: "Flutter Fashion",
                    hasBackArrow: false,
                    hasTitle: true,
                  ))
            ],
          )),
    );
  }
}