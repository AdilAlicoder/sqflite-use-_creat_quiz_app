import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/sqflite_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
void main() {
  runApp(data());
}
class data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body:homepage(),
      ),
    );
  }
}
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage>  with TickerProviderStateMixin{

  int timer=0;
  String question,a,b,c,d,ans;
  int i=1,score=0;
  String scroetxt='0/5';
  final dbhelper=DatabaseHelper.instance;
  Timer _timer;
  int _start = 10;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
    next();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Start the periodic timer which prints something every 1 seconds
    setState(() {
      qureyspecific();
    });
  }
  void qureyspecific() async{
    var allrows = await dbhelper.queryspecific(i);
    allrows.forEach((row){
      setState(() {
        question=row["Question"];
        a=row["A"];
        b=row["B"];
        c=row["C"];
        d=row["D"];
        ans=row["Answer"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final double width=MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              '$scroetxt',
              style: TextStyle(color: Colors.lime,fontWeight: FontWeight.w600,fontSize: 25.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0,left: 15.0),
          child: Container(
            width: MediaQuery.of(context).size.width/1.1,
            height: MediaQuery.of(context).size.height/13,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white38)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$question',style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
              ),),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              highlightColor: Colors.yellow,
              onTap: (){
                if(ans==a){
                  score++;
                  setState(() {
                    scroetxt = ('$score''/5');
                  });
                  next();
                }
                else{
                  next();
                }
              },
              child: Text('$a',style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.w500),)),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              highlightColor: Colors.yellow,
              onTap: (){
                if(b==ans){
                  score++;
                  setState(() {
                    scroetxt = ('$score''/5');
                  });
                  next();
                }
                else{
                  next();
                }
              },
              child: Text('$b',style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.w500),)),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              highlightColor: Colors.yellow,
              onTap: (){
                if(ans==c){
                  score++;
                  setState(() {
                    scroetxt = ('$score''/5');
                  });
                  next();
                }
                else{
                  next();
                }
              },
              child: Text('$c',style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.w500),)),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              highlightColor: Colors.yellow,
              onTap: (){
                if(ans==d){
                  score++;
                  setState(() {
                    scroetxt = ('$score''/5');
                  });
                  next();
                }
                else{
                  next();
                }
              },
              child: Text('$d',style: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.w500),)),
        ),
        Padding(
          padding: const EdgeInsets.all(17.0),
          child: Center(
            child: RaisedButton(
              splashColor: Colors.blue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              highlightColor: Colors.white,
              onPressed: (){
                setState(() {
                  _start=10;
                });
                startTimer();
              },
              child: Container(
                child: Center(child: Text('Next',style: TextStyle(color: Colors.indigo,fontSize: 30.0,fontWeight: FontWeight.w500),)),
                width: MediaQuery.of(context).size.width/1.7,
                height: MediaQuery.of(context).size.height/14,
              ),
              color: Colors.lime,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Text('$_start',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),)),
      ],
    );
  }

  void next() {
    if(i<5){
      i=i+1;
    }
    else{
      print(score);
    }
    qureyspecific();
  }
}
