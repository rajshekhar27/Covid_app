import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Model/worldStatesModel.dart';
import 'api_url.dart';

class StatesServices{
  Future<WorldStatesModel> getworldsStates() async{
    final response= await http.get(Uri.parse(ApiUrl.WorldStatesApi));

    if(response.statusCode==200){
      var data= jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getCountryName() async{
    var data;
    final response= await http.get(Uri.parse(ApiUrl.countriesList));

    if(response.statusCode==200){
      data= jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception("Error");
    }
  }

}
