import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io'; // For working with File
import 'package:provider/provider.dart';

class datapkg{
  String i, des;
  datapkg(this.i, this.des);

  String getImageURL(){
    return this.i;
  }
  String getDescription(){
    return this.des;
  }
}

class dataStorage{
  dataStorage();

  List<String> newImages = [
      // Add 10 image URLs here for demonstration
      
    ];

   /* List<String> newDescriptions = [
     ,
      ,
      ,
      'A field of colorful wildflowers stretches as far as the eye can see, each bloom adding a vibrant touch to the landscape. The variety of red, yellow, and purple flowers sways gently with the breeze under a clear sky. It’s a scene that embodies the joy and renewal of spring, inviting viewers to immerse themselves in the beauty of nature.',
      'A lone tree stands defiantly against a dark and stormy sky, its branches swaying in the wind. The dramatic clouds gather ominously above, hinting at a powerful storm brewing. This image captures the resilience of nature amidst adversity, reminding viewers of the strength and perseverance required to weather life’s challenges.',
      'A snow-covered mountain peak rises majestically against a backdrop of golden morning light. The first rays of dawn touch the summit, creating a stunning contrast between the white snow and the warm, golden hues. It’s a breathtaking scene that symbolizes new beginnings and the beauty that lies in remote, untouched places.',
      'The beach is bathed in the soft glow of dusk, with gentle waves rolling onto the sandy shore. The horizon blends seamlessly with the colors of the setting sun, creating a peaceful and calming atmosphere. This scene is perfect for those who love the ocean, offering a serene escape from the demands of daily life.',
      'A thick fog blankets a dense forest, creating an air of mystery and intrigue. The trees fade into the mist, giving the impression that the forest stretches infinitely. This image evokes a sense of wonder and curiosity, as if inviting viewers to step into an unexplored world where anything might be possible.',
      'The night sky comes alive with a stunning display of stars over a quiet desert landscape. The Milky Way arcs across the sky, its glow highlighting the vastness of the universe. The serene and desolate desert below contrasts with the brilliance above, making this scene a reminder of our place in the cosmos.',
      'A quaint village nestled in rolling hills is adorned with vibrant autumn colors. The golden and red leaves create a warm and inviting atmosphere, with cottages dotting the landscape. This scene captures the charm of rural life in autumn, where nature and community come together to create a picturesque and comforting setting.',
    ];*/
  static List<datapkg> data = [datapkg('https://media.cnn.com/api/v1/images/stellar/prod/ap24294169788999-copy.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp', 'This image captures a stunning sunset over a mountain range, where the sky is painted with vibrant orange and pink hues. The shadows of the peaks create a dramatic contrast, making the scene look like a masterpiece of nature. It evokes a sense of tranquility and awe, perfect for those who appreciate nature’s beauty.'),
      datapkg('https://picsum.photos/300/200?image=2','A serene lake mirrors the surrounding forest and sky in this tranquil scene. The water’s surface is so still that the trees and clouds create a near-perfect reflection, blending reality with illusion. This peaceful setting invites viewers to pause, reflect, and enjoy the natural beauty away from the hustle and bustle of daily life.'),
      datapkg('https://picsum.photos/300/200?image=3','The image showcases a bustling cityscape during nighttime, with streets reflecting the vibrant lights of the skyscrapers. Neon signs and glowing windows illuminate the scene, giving a sense of the city’s energy and life. This visual captures the fast-paced rhythm of urban life, highlighting the contrast between the bright lights and the dark sky.'),
      datapkg('https://picsum.photos/300/200?image=4', 'a'),
      datapkg('https://picsum.photos/300/200?image=5', 'aa'),
      datapkg('https://picsum.photos/300/200?image=6', 'aa'),
      datapkg('https://picsum.photos/300/200?image=7', 'aa'),
      datapkg('https://picsum.photos/300/200?image=8', 'aa'),
      datapkg('https://picsum.photos/300/200?image=9', 'aa'),
      datapkg('https://picsum.photos/300/200?image=10', 'aa'),];

  void addData(String img, String desc){
    data.add(datapkg(img, desc));
  }

  void setDesc(int index, String desc){
    data[index] = datapkg(data[index].i, desc);
  }

  void setImg(int index, String img){
    data[index] = datapkg(img, data[index].des);
  }

  datapkg getData(int index){
    return data.elementAt(index);
  }
}