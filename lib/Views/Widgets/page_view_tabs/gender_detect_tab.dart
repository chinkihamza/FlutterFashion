import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/Widgets/action_bar.dart';
import 'package:flutter_fashion/Views/Widgets/page_view_tabs/outfit_detect.dart';
import 'package:flutter_fashion/Views/search_results.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class GenderDetect extends StatefulWidget {
  const GenderDetect({Key? key}) : super(key: key);

  @override
  _GenderDetectState createState() => _GenderDetectState();
}

class _GenderDetectState extends State<GenderDetect> {
  bool _loading = true;
  late File _image;
  late List _output=[];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
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
        model: 'assets/gender_model.tflite', labels: 'assets/gender_labels.txt');
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
    _loading = false;
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
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
                                  _image,
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
                                          builder: (context) => OutfitDetect(
                                            gender: '${_output[0]['label']}',
                                            img: _image,
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
                                      'Continue',
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
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              'Take A Photo',
                              style: TextStyle(
                                fontFamily: "FiraSansCondensed",
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: pickGalleryImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              'Pick From Gallery',
                              style: TextStyle(
                                fontFamily: "FiraSansCondensed",
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
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


