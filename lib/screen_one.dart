import 'package:demo/screen_two.dart';
import 'package:demo/src/colors/d_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key,}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  TextEditingController name = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1"),
        backgroundColor: DColors.blue,
      ),
      body: Screen(),
    );
  }

  Widget Screen(){
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 9,),
            Center(
              child: Text(
                "Enter your name",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "NotoSans-Bold",
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 206,),
            _editName(),
            SizedBox(height: 56,),
            _btnNext(),

        ],
        ),
      ),
    );
  }

  _editName() {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 42,
      width: 305.0,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0,horizontal:10 ),
          child: _nameTextField()
      ),
    );
  }

  _nameTextField() => TextField(
      keyboardType: TextInputType.name,
      controller: name,
      autofocus: false,
      autocorrect: false,
      style: TextStyle(
          color: Colors.black, fontFamily: 'NotoSans'),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Your name',
        hintStyle: TextStyle(
            color: Colors.black45,
            fontFamily: 'NotoSans'),
      )
  );

  _handleNext() async {
    if (name.text.isEmpty == true) {
      showToast("Please enter your name");
      return;
    }else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScreenTwo(name: name.text,)));
    }
  }

  _btnNext() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child:Container(
        height: 49.0,
        width: 305.0,
        decoration: BoxDecoration(
            color: DColors.blue2,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            _handleNext();
          },
          child:Center(
            child: Text(
              "Next Screen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'NotoSans-Bold', fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: MediaQuery.of(context).viewInsets.bottom == 0 ? ToastGravity.BOTTOM : ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
