

import 'dart:convert';

import 'package:covidtracker/Model/country_model.dart';
import 'package:covidtracker/Model/world_case_model.dart';
import 'package:covidtracker/Services/Utilities/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class GetServices{

  Future<WorldCaseModel> getWorldWideData()async{
   final response=await http.get(Uri.parse(AppUrl.worldStatesUrl));

   if(response.statusCode==200){
     var data=jsonDecode(response.body);
     return WorldCaseModel.fromJson(data);


  }
   else{
     throw Exception('e');
   }


}
Future<List<CountryModel>> getCountryData()async{
    final response=await http.get(Uri.parse(AppUrl.countriesListUrl));

    if(response.statusCode==200 || response.statusCode == 201){

      List<dynamic> data=jsonDecode(response.body);
      debugPrint(response.body);
      return data.map((e)=> CountryModel.fromJson(e)).toList();

    }
    else{
      throw Exception('e');
    }

}




}