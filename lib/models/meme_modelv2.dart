// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';



class ModelMeme extends ChangeNotifier{
  bool success;
  Data data;

  ModelMeme({required this.success, required this.data,});

  factory ModelMeme.fromJson(Map<String, dynamic> parsedJson){
    return ModelMeme(
        success: parsedJson['success'],
        data: Data.fromJson(parsedJson['data'])
    );
  }

  // ModelMeme.formJson(dynamic parsedJson){
  //   success = parsedJson['success'] as bool;
  //   data = Data.fromJson(parsedJson['data']);
  // }

  // ModelMeme.fromJson(Map<String, dynamic> json)
  //     : success            = json['success'] as bool,
  //       data      = Data.fromJson(json['data']);
  //
  // Map<String, dynamic> toJson() => {
  //   'success': success,
  //   'data': data.memes,
  // };
}

class Data extends ChangeNotifier{
  final List<Memes> memes;
  Data({required this.memes,});

  factory Data.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['memes'] as List;
    print("Gioi ${list.runtimeType.toString()}");
    List<Memes> memeList = list.map((i) => Memes.fromJson(i)).toList();


    return Data(
        memes: memeList
    );
  }

  // Data.fromJson(dynamic responseJson) {
  //   List listData = responseJson['memes'] as List;
  //   print(listData.runtimeType);
  //   // List data = json.decode(responseJson.body)['memes']['memes'];
  //   // memes = data.map((itemJson) =>
  //   memes = listData.map((itemJson) => Memes.fromJson(itemJson)).toList();
  // }
}

class Memes {
  final String id;
  final String name;
  final String url;
  final int width;
  final int height;
  final int boxCount;

  Memes(
      {required this.id, required this.name, required this.url, required this.width, required this.height,required this.boxCount});

  factory Memes.fromJson(Map<String, dynamic> parsedJson){
    return Memes(
        id: parsedJson['id'],
        name: parsedJson['name'],
        url: parsedJson['url'],
        width: parsedJson['width'],
        height: parsedJson['height'],
      boxCount: parsedJson['box_count']
    );
  }
}

// class Memes extends ChangeNotifier{
//   String id;
//   String name;
//   String url;
//   int width;
//   int height;
//  // int boxcount;
//
//   Memes(this.url,this.name,this.id,this.height,this.width);
//
//   Memes.fromJson(Map<String, dynamic> json)
//       : id            = json['id'] as String,
//         name = json['name'] as String,
//         url = json['url'] as String,
//         width = json['width'] as int,
//         height = json['height'] as int;
//        // boxcount = json['boxcount'] as int;
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'url':url,
//     'width':width,
//     'height':height
//   };
// }


