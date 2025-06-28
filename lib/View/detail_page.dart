import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String ?cases,recoverd,death,critical,population,flag,countryname;
   DetailPage({super.key,required this.cases,required this.recoverd,required this.death,required this.critical,required this.population,required this.flag,required this.countryname});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.countryname.toString()),),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0,right: 0,left: 0),
        child: Container(
          height: 600,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [


              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Card(
                  color:Colors.blueGrey.shade100,
                  child: Column(

                    children: [
                      ResuableRow('Total Popualation',widget.population.toString()),
                      ResuableRow('Total Cases', widget.cases.toString()),
                      ResuableRow('Total Death', widget.death.toString()),
                      ResuableRow('Total Recoverd', widget.recoverd.toString()),
                      ResuableRow('Total Critical', widget.critical.toString()),

                    ],

                  ),
                ),
              ),
              Positioned(
                top: 15,




                child: CircleAvatar(
                  radius: 50,

                  backgroundImage: NetworkImage(widget.flag.toString()),
                ),
              ),
            ],


          ),
        ),
      ),

    );
  }
}
Widget ResuableRow(String title,String value){
  final style=TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600
  );


  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: style,),
            Text(value,style: style,),
          ],
        )
      ],

    ),
  );
}
