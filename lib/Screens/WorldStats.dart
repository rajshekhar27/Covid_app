import 'package:covid_app/Model/worldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../services/utilities/States_Services.dart';
import 'Country_list.dart';


class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldstatsState();
}

class _WorldstatsState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late AnimationController _controller= AnimationController(
      duration: Duration(seconds: 3),
      vsync: this);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  List<Color> colorlist=[
    Color(0XFF4285F4),
    Color(0XFF1aa260),
    Color(0XFFde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();

    return Scaffold(
      backgroundColor: Colors.grey,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .02),

            FutureBuilder(
                future: statesServices.getworldsStates(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        )
                    );
                  }else{
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total":double.parse(snapshot.data!.cases!.toString()),
                                "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                                "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorlist,
                              chartRadius: MediaQuery.of(context).size.width/3.2,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .03),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.grey.shade300,
                                child: Column(
                                  children: [
                                    ReUsableRow(title: "Total Cases", value: snapshot.data!.cases!.toString()),
                                    ReUsableRow(title: "Total Deaths", value: snapshot.data!.deaths.toString()),
                                    ReUsableRow(title: "Total Recovered", value:snapshot.data!.recovered!.toString()),
                                    ReUsableRow(title: "Total Active" , value: snapshot.data!.active!.toString()),
                                    ReUsableRow(title: "Total Critical", value: snapshot.data!.critical!.toString()),
                                    ReUsableRow(title: "Today Cases", value: snapshot.data!.todayCases!.toString()),
                                    ReUsableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths!.toString()),
                                    ReUsableRow(title: "Today Recovers", value: snapshot.data!.todayRecovered!.toString()),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap:(){
                                  Navigator.push( context, MaterialPageRoute(builder: (context)=> CountryList()));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0XFF1aa260),
                                  ),
                                  child: Center(
                                    child: Text("Track Countries",style: TextStyle(color: Colors.white, fontSize: 15),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                  }
                }),
          ],
                ),
        ),) ,
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
