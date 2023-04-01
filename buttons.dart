import 'package:flutter/material.dart';
class Mybutton extends StatelessWidget {

  final color;
  final textcolor;
  final textcon;
  final buttontapped;
  const Mybutton({this.color,this.textcolor,this.textcon,this.buttontapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:buttontapped,
      child: Padding(
              padding:const EdgeInsets.all(8.0),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: color,
                child: Center(child: Text(textcon,style:TextStyle(color:textcolor),),),
              ),
              ),

      ),
    );
  }
}
