import 'package:covidtracker/Model/country_model.dart';
import 'package:covidtracker/Services/get_services.dart';
import 'package:covidtracker/View/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {

  final SearchController searchController=SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),

            SearchBar(
              hintText: 'Search Country Name',
              controller: searchController,
              onChanged: (value){
                setState(() {

                });
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<List<CountryModel>>(
              future: GetServices().getCountryData(),
              builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
              // if(!snapshot.hasData){
                  return Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    child: ListView.builder(

                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.black,
                          enabled: true,
                          highlightColor: Colors.red,
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                ),

                                title: Container(
                                  height: 10,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  debugPrint("I go the data");
                  final styles = TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  );
                  return SizedBox(

                    height: MediaQuery.of(context).size.height * 0.8,



                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String countryname=snapshot.data![index].country.toString();
                        if(searchController.text.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(
                                cases: snapshot.data![index].cases.toString(),
                                recoverd: snapshot.data![index].recovered.toString(),
                                death: snapshot.data![index].deaths.toString(),
                                critical: snapshot.data![index].critical.toString(),
                                population: snapshot.data![index].population.toString(),
                                flag: snapshot.data![index].countryInfo!.flag.toString(),
                                countryname: snapshot.data![index].country.toString(),
                              )));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                //here flag is inside countryinfo.which was another key
                                backgroundImage: NetworkImage(
                                  snapshot.data![index].countryInfo!.flag!,
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].country ?? '',
                                style: styles,
                              ),
                              subtitle: Text(
                                "${snapshot.data![index].population}",
                                style: styles,
                              ),
                            ),
                          );

                        }
                        else if(countryname.toLowerCase().contains(searchController.text.toLowerCase())){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(
                                cases: snapshot.data![index].cases.toString(),
                                recoverd: snapshot.data![index].recovered.toString(),
                                death: snapshot.data![index].deaths.toString(),
                                critical: snapshot.data![index].critical.toString(),
                                population: snapshot.data![index].population.toString(),
                                flag: snapshot.data![index].countryInfo!.flag.toString(),
                                countryname: snapshot.data![index].country.toString(),
                              )));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                //here flag is inside countryinfo.which was another key
                                backgroundImage: NetworkImage(
                                  snapshot.data![index].countryInfo!.flag!,
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].country ?? '',
                                style: styles,
                              ),
                              subtitle: Text(
                                "${snapshot.data![index].population}",
                                style: styles,
                              ),
                            ),
                          );

                        }

                        else{
                          return Container(

                          );
                        }

                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
