import 'dart:ffi';

import 'package:covidtracker/Model/world_case_model.dart';
import 'package:covidtracker/Services/get_services.dart';
import 'package:covidtracker/View/country_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Worldwide Cases',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
          FutureBuilder(
            future: GetServices().getWorldWideData(),
            builder: (context, AsyncSnapshot<WorldCaseModel> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                var items = snapshot.data!;
                return Column(
                  children: [
                    PieChart(//from api
                      dataMap: {
                        'Total': double.parse(items.cases!.toString()),
                        'Death': double.parse(items.deaths!.toString()),
                        'Recovered': double.parse(items.recovered!.toString()),
                        'Active': double.parse(items.active!.toString()),
                        'Critical': double.parse(items.critical!.toString()),
                        'Today Cases': double.parse(
                          items.todayCases!.toString(),
                        ),
                        'Today Deaths': double.parse(
                          items.todayDeaths!.toString(),
                        ),
                      },
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        children: [
                          _builTableRow('Title', 'Values', isHeader: true),
                          _builTableRow(
                            'Total Cases',
                            snapshot.data!.cases.toString(),
                          ),

                          _builTableRow(
                            'Total Deaths',
                            snapshot.data!.deaths.toString(),
                          ),
                          _builTableRow(
                            'Total Recovered',
                            snapshot.data!.recovered.toString(),
                          ),
                          _builTableRow(
                            'Active',
                            snapshot.data!.active.toString(),
                          ),
                          _builTableRow(
                            'Critical',
                            snapshot.data!.critical.toString(),
                          ),
                          _builTableRow(
                            'Today Cases',
                            snapshot.data!.todayCases.toString(),
                          ),
                          _builTableRow(
                            'Today Deaths',
                            snapshot.data!.todayDeaths.toString(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),


                    Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        width:double.infinity,
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple

              ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
                          },
                          child: Text('Show Country Wise',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

TableRow _builTableRow(String title, String value, {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 18.0,
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
  );
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value, style: style),
      ),
    ],
  );
}
