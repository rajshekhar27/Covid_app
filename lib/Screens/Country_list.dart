
import 'package:covid_app/services/utilities/States_Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'DetailScreen.dart';


class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices countryName= StatesServices();

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade400,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search country",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                )
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future:countryName.getCountryName(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10,width: 89,color: Colors.white,),
                                    subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                    leading: Container(height: 50,width: 50,color: Colors.white,),
                                  ),
                                ],
                              ),
                              baseColor: Colors.white,
                              highlightColor: Colors.white);

                        });
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          String? name=snapshot.data![index]['country'];
                          if(searchController.text.isEmpty)
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailscreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        cases: snapshot.data![index]['cases'],
                                        todayDeaths: snapshot.data![index]['todayDeaths'],
                                        recovered: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        tests: snapshot.data![index]['tests'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag']
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            }else if(name!.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailscreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      cases: snapshot.data![index]['cases'],
                                      todayDeaths: snapshot.data![index]['todayDeaths'],
                                      recovered: snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      tests: snapshot.data![index]['tests'],
                                    ),
                                    ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }

                    });
                  }
                },),
          ),

        ],
      )),
    );
  }
}
