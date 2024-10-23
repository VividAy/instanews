import 'package:flutter/material.dart';

class datapkg {
  String i, des, title, link;
  List<String> tags = [];
  datapkg(this.i, this.des, this.title, this.link);

  String getImageURL() {
    return this.i;
  }

  String getDescription() {
    return this.des;
  }

  String getTitle() {
    return this.title;
  }

  void addTag(String t){
    tags.add(t);
  }

  bool checkTag(String t){
    for(String t2 in tags){
      if(t2 == t){return true;}
    }
    return false;
  }
}

class dataStorage {
  dataStorage();

  static List<datapkg> data = [];
  static int numPkgs = 0;

  void addData(String img, String desc, String title, link, List <String> tags) {
    datapkg r = datapkg(img, desc, title, link);
    for(String i in tags){
      r.addTag(i);
    }
    data.add(r);
    numPkgs++;
  }

  // Method to update the description of an existing entry
  void setDesc(int index, String desc) {
    data[index] = datapkg(data[index].i, desc, data[index].title, data[index].link);
  }

  void setImg(int index, String img) {
    data[index] = datapkg(img, data[index].des, data[index].title, data[index].link);
  }

  void setTitle(int index, String title) {
    data[index] = datapkg(data[index].i, data[index].des, title, data[index].link);
  }

  datapkg getData(int index) {
    return data.elementAt(index);
  }

  String getLink(int index){
    return data[index].link;
  }

  int getNumPkgs(){
    return numPkgs;
  }
}