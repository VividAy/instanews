import 'package:flutter/material.dart';

class datapkg {
  String i, des, title;
  datapkg(this.i, this.des, this.title);

  String getImageURL() {
    return this.i;
  }

  String getDescription() {
    return this.des;
  }

  String getTitle() {
    return this.title;
  }
}

class dataStorage {
  // List of default datapkg objects
  static List<datapkg> _defaultData = [
    datapkg(
      'https://media.cnn.com/api/v1/images/stellar/prod/ap24294169788999-copy.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp',
      'This image captures a stunning sunset over a mountain range, where the sky is painted with vibrant orange and pink hues. The shadows of the peaks create a dramatic contrast, making the scene look like a masterpiece of nature. It evokes a sense of tranquility and awe, perfect for those who appreciate nature’s beauty.',
      'Sunset over the Mountains',
    ),
    datapkg(
      'https://picsum.photos/300/200?image=2',
      'A serene lake mirrors the surrounding forest and sky in this tranquil scene. The water’s surface is so still that the trees and clouds create a near-perfect reflection, blending reality with illusion. This peaceful setting invites viewers to pause, reflect, and enjoy the natural beauty away from the hustle and bustle of daily life.',
      'Reflection at the Lake',
    ),
    datapkg(
      'https://picsum.photos/300/200?image=3',
      'The image showcases a bustling cityscape during nighttime, with streets reflecting the vibrant lights of the skyscrapers. Neon signs and glowing windows illuminate the scene, giving a sense of the city’s energy and life. This visual captures the fast-paced rhythm of urban life, highlighting the contrast between the bright lights and the dark sky.',
      'Nighttime Cityscape',
    ),
    datapkg('https://picsum.photos/300/200?image=4', 'Description for image 4',
        'Title 4'),
    datapkg('https://picsum.photos/300/200?image=5', 'Description for image 5',
        'Title 5'),
    datapkg('https://picsum.photos/300/200?image=6', 'Description for image 6',
        'Title 6'),
    datapkg('https://picsum.photos/300/200?image=7', 'Description for image 7',
        'Title 7'),
    datapkg('https://picsum.photos/300/200?image=8', 'Description for image 8',
        'Title 8'),
    datapkg('https://picsum.photos/300/200?image=9', 'Description for image 9',
        'Title 9'),
    datapkg('https://picsum.photos/300/200?image=10',
        'Description for image 10', 'Title 10'),
  ];

  // List that holds both the default and user-added data
  static List<datapkg> _userData = [];

  // Combine the default data with user-added data
  List<datapkg> get data => [..._defaultData, ..._userData];

  // Method to add new data entries
  void addData(String img, String desc, String title) {
    _userData.add(datapkg(img, desc, title));
  }

  // Method to update the description of an existing entry
  void setDesc(int index, String desc) {
    if (index < _defaultData.length) {
      _defaultData[index] =
          datapkg(_defaultData[index].i, desc, _defaultData[index].title);
    } else {
      int userIndex = index - _defaultData.length;
      _userData[userIndex] =
          datapkg(_userData[userIndex].i, desc, _userData[userIndex].title);
    }
  }

  // Method to update the image URL of an existing entry
  void setImg(int index, String img) {
    if (index < _defaultData.length) {
      _defaultData[index] =
          datapkg(img, _defaultData[index].des, _defaultData[index].title);
    } else {
      int userIndex = index - _defaultData.length;
      _userData[userIndex] =
          datapkg(img, _userData[userIndex].des, _userData[userIndex].title);
    }
  }

  // Method to update the title of an existing entry
  void setTitle(int index, String title) {
    if (index < _defaultData.length) {
      _defaultData[index] =
          datapkg(_defaultData[index].i, _defaultData[index].des, title);
    } else {
      int userIndex = index - _defaultData.length;
      _userData[userIndex] =
          datapkg(_userData[userIndex].i, _userData[userIndex].des, title);
    }
  }

  // Method to retrieve a specific data entry
  datapkg getData(int index) {
    if (index < _defaultData.length) {
      return _defaultData.elementAt(index);
    } else {
      return _userData.elementAt(index - _defaultData.length);
    }
  }
}