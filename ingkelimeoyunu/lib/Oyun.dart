import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proje/Anasayfa.dart';
import 'dart:math';
import 'package:proje/Kelimeler.dart';
import 'package:proje/size.dart';
import 'package:proje/kuturenk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'dart:async';

class Oyu extends GetxController {





  var score = 0.obs;
//takip etmek istenilen parametrelere obs kullanılır.
  Artis() => score++;
  var time = 0.obs;
  var ranHead = 0.obs;

  Randomeslestir() {
    //Random eşleştirme.
    ranHead = Random().nextInt(4).obs;
    if (ranHead == 0) {
      ranHead = ran1;
    } else if (ranHead == 1) {
      ranHead = ran2;
    } else if (ranHead == 2) {
      ranHead = ran3;
    } else if (ranHead == 3) {
      ranHead = ran4;
    }
    print("head");
    print(ranHead);
    update();
    //program kendini güncellese bile update kullanarak işimizi garantiye almış oluyoruz.
  }
  var backImage = [
    "Reso/doga1.jpg",
    "Reso/doga2.jpg",
    "Reso/doga3.jpg",
    "Reso/doga4.jpg",
    "Reso/doga5.jpg",
    "Reso/doga6.jpg",


  ].toList();

  var ran1 = 0.obs;
  var ran2 = 0.obs;
  var ran3 = 0.obs;
  var ran4 = 0.obs;


  randomkontrol() {
    //Rastgele çıkan kelimelerin aynı olmaması için kontrol ediyoruz.

    ran1 = Random().nextInt(Trkelime.length).obs;
    ran2 = Random().nextInt(Trkelime.length).obs;
    ran3 = Random().nextInt(Trkelime.length).obs;
    ran4 = Random().nextInt(Trkelime.length).obs;
    if (ran2 == ran1 || ran1 == ran3 || ran1 == ran4) {
      while (ran2 == ran1 || ran1 == ran3 || ran1 == ran4) {
        ran1 = Random().nextInt(Trkelime.length).obs;
      }
    }
    if (ran2 == ran1 || ran2 == ran3 || ran2 == ran4) {
      while (ran2 == ran1 || ran2 == ran3 || ran2 == ran4) {
        ran2 = Random().nextInt(Trkelime.length).obs;
      }
    }
    if (ran3 == ran1 || ran3 == ran2 || ran3 == ran4) {
      while (ran3 == ran1 || ran3 == ran2 || ran3 == ran4) {
        ran3 = Random().nextInt(Trkelime.length).obs;
      }
    }
    if (ran4 == ran1 || ran4 == ran2 || ran3 == ran4) {
      while (ran4 == ran1 || ran4 == ran2 || ran3 == ran4) {
        ran4 = Random().nextInt(Trkelime.length).obs;
      }
    }
    print("sayılar");
    print(ran1);
    print(ran2);
    print(ran3);
    print(ran4);

    update();
  }



  var fakeImage = [].toList().obs;
  var Trkelime = [].toList().obs;
  var ingkelime = [].toList().obs;
  Listedencekme() {
    //Kelimeler.dart'ta ki kelimeleri yeni bir listeye çekiyoruz.

    for (var i = 0; i < KelimeTR.length; i++) {
      Trkelime.add(KelimeTR[i]);
      ingkelime.add(Kelimeing[i]);
      fakeImage.add(Ressi[i]);
    }
    update();
  }


  SeciliKontrol(int num, BuildContext context) {

    if (ranHead == num) {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: displayHeight(context) * 0.4,
              child: AlertDialog(
                backgroundColor: Colors.green,
                title: Icon(Icons.check_circle_sharp,
                    color: Colors.white, size: 75),
                content: Container(
                    height: displayHeight(context) * 0.07,
                    child: Center(
                        child: Text(
                          "Congratulations!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35),
                        ))),
                actions: [
                  IconButton(
                    icon: Icon(Icons.home_filled, color: Colors.white),
                    iconSize: 50,
                    onPressed: () {

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => anasayfa(),
                        ),
                            (route) => false,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right_alt_outlined,
                        color: Colors.white),
                    iconSize: 50,
                    onPressed: () {

                      score += 10;
                      print("girdi");
                      Sil();
                      randomkontrol();
                      Randomeslestir();
                      _scorukaydet();
                      _scorugetir();
                      Navigator.pop(context);

                    },
                  ),
                ],
              ),
            );
          });
    } else {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: displayHeight(context) * 0.4,
              child: AlertDialog(
                backgroundColor: Colors.red,
                title: Icon(Icons.cancel, color: Colors.white, size: 75),
                content: Container(
                    height: displayHeight(context) * 0.07,
                    child: Center(
                        child: Text(
                          "Unfortunately",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35),
                        ))),
                actions: [
                  IconButton(
                    icon: Icon(Icons.home_filled, color: Colors.white),
                    iconSize: 50,
                    onPressed: () {
                      _sifirla();
                      _scorugetir();




                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => anasayfa(),
                        ),
                            (route) => false,
                      );
                      //  Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  Sil() {
//  Cevabı çıkan kelimenin bir daha çıkmaması için siliyoruz.
    fakeImage.removeAt(ranHead.toInt());
    ingkelime.removeAt(ranHead.toInt());
    Trkelime.removeAt(ranHead.toInt());
    print("fake");
    print(Trkelime.length);
    update();
  }

  Future _scorukaydet() async {
    //Datayı tutmak için sharedpreferences(basit key-value değerlerini tutar) kullanldı.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("score", score.toInt());
  }

  Future _scorugetir() async {
    var tempScore;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tempScore = prefs.getInt("score");
    score.value = tempScore;
  }

  Future _sifirla() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("score", 0);
  }


  void onInit() {

    _sifirla();
    randomColors();
    Listedencekme();
    randomkontrol();
    Randomeslestir();

    super.onInit();
  }
}

class oyunvakti extends StatelessWidget {
//Yukarıdaki değişkenleri ve obs'leri daha rahat kullanmak için bir değişken oluşturduk.
  final Oyu c = Get.put(Oyu());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body:SafeArea(
            child: Container(
                child: Container(
                  padding: EdgeInsets.only(top: 0),
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(c.backImage[Random().nextInt(6)]),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => anasayfa(),
                                ),
                                    (route) => false,
                              );

                              //  Get.offAndToNamed("/");
                            },
                            icon: Icon(Icons.home_filled, size: 50, color: Colors.white)),
                      ),
                      Padding(

                          padding: EdgeInsets.all(25),
                          child:
                          Container(
                            width: displayWidth(context) * 0.3,
                            height: displayHeight(context) * 0.05,
                            decoration: BoxDecoration(
                                color: container2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Obx(() => Text(
                                "SCORE: ${c.score}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              )),
                            ),
                          )

                      ),

                      Container(
                        width: displayWidth(context) * 0.6,
                        height: displayHeight(context) * 0.08,
                        color: container1,
                        margin: EdgeInsets.only(top: 25),
                        child: Center(
                            child: Obx(() => Text(
                              "${c.ingkelime[c.ranHead.toInt()]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                            ))),
                      ),
                      Expanded(
                        child: GridView.count(
                          padding: EdgeInsets.only(top: 60, left: 10, right: 10),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 2,
                          children: [
                            GestureDetector(
                              onTap: () {
                                c.SeciliKontrol(c.ran1.toInt(), context);
                              },
                              child: Container(
                                color: container3,
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                          () => Image.asset(
                                        '${c.fakeImage[c.ran1.toInt()]}',
                                        height: 100,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(top: 30 ),
                                    child: Obx(() => Text(
                                      "${c.Trkelime[c.ran1.toInt()]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25 ),
                                    )),
                                  ),
                                ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                c.SeciliKontrol(c.ran2.toInt(), context);
                              },
                              child: Container(
                                color: container5,
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                          () => Image.asset(
                                        '${c.fakeImage[c.ran2.toInt()]}',
                                        height: 100,
                                      ),
                                    ),
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Obx(
                                            () => Text(
                                          "${c.Trkelime[c.ran2.toInt()]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                c.SeciliKontrol(c.ran3.toInt(), context);
                              },
                              child: Container(
                                color: container6,
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                          () => Image.asset(
                                        '${c.fakeImage[c.ran3.toInt()]}',
                                        height: 100,
                                      ),
                                    ),
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Obx(
                                            () => Text(
                                          "${c.Trkelime[c.ran3.toInt()]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                c.SeciliKontrol(c.ran4.toInt(), context);
                              },
                              child: Container(
                                color: container4,
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                          () => Image.asset(
                                        '${c.fakeImage[c.ran4.toInt()]}',
                                        height: 100,
                                      ),
                                    ),
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Obx(
                                            () => Text(
                                          "${c.Trkelime[c.ran4.toInt()]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
