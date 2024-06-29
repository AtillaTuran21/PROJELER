
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proje/Oyun.dart';
import 'package:proje/size.dart';
import 'package:get/get.dart';

class anasayfa extends StatefulWidget {
  const anasayfa({super.key});

  @override
  State<anasayfa> createState() => _anasayfaState ();
}

class _anasayfaState extends State<anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "Reso/arkap.jpg",
                  ),
                  fit: BoxFit.cover,
                )),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 90),
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        "Unit 7.WORD GAME",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: displayWidth(context) * 0.3,
                      height: displayHeight(context) * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25)),
                      child: IconButton(
                        icon: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 90,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => oyunvakti(),
                            ),
                                (route) => false,
                          );                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 125),
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "BY AT21",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),



                  ],
                ),
              ),
            ),
          )),
    );
  }
  
}
