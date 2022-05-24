import 'package:demo/constants.dart';
import 'package:demo/models/meme_modelv2.dart';
import 'package:demo/src/colors/d_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'services/api_service.dart';

class ScreenTwo extends StatefulWidget {
  String name;
  ScreenTwo({Key? key,required this.name}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<Memes> listMemes = [];
  ModelMeme? mResponse;
  Future? getMemeFuture;
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemeFuture = getItem();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }



  Future<List<Memes>?> getItem() async {
    try{
      await ApiService.create()
          .getmemes()
          .then((dataItem) {
        print("Gioi ${dataItem.data.memes.toList().toString()}");
        setState(() {
          mResponse = dataItem;
          listMemes = dataItem.data.memes;
          //listMemes = dataItem.data.memes;
        });
      });
      return listMemes;
    }catch(obj){
      print(obj);
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Gioi error ${res!.statusCode}");
          break;
        default:
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
        backgroundColor: DColors.blue,
      ),
      body: Screen(),
      floatingActionButton:FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  Widget Screen(){
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 9,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "NotoSans-Bold",
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "NotoSans-Bold",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                    height:size.height * 0.80,
                    child: RefreshIndicator(
                        onRefresh: () async{await getItem();  },
                        child: buildListMeme())),
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ],
    );
  }

  Widget buildListMeme(){
    if(listMemes.length > 0){
      return ListView.builder(
        controller: _scrollController,
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          itemCount: listMemes.length,
          itemBuilder: (context,index){
            Memes item = listMemes[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: itemUser(url: item.url,name: item.name,width: item.width,height: item.height,id: item.id,),
            );
          });
    }else{
      return Container();
    }
  }



}

class itemUser extends StatelessWidget {
  final String? url;
  final String? name;
  final int? width;
  final int height;
  final String id;
  const itemUser({
    Key? key,
    required this.url,
    this.name,required this.height,this.width,required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 74,
      color: DColors.sliver,
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      backgroundImage: NetworkImage(url!),
                    ),
                  ),
                  SizedBox(width: 0,),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(right: 40),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "NotoSans-Bold",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text("${width} x ${height}",style: TextStyle(fontSize: 10),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.66,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(id,textAlign: TextAlign.end,style: TextStyle(
                      fontSize: 10
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
