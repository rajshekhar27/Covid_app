import 'package:flutter/material.dart';

import 'WorldStats.dart';

class Detailscreen extends StatefulWidget {
  String name;
  String image;
  int cases, todayDeaths, recovered, active, critical, todayRecovered, tests;

  Detailscreen({
    required this.name,
    required this.image,
    required this.cases,
    required this.todayDeaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });


  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067,),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                        ReUsableRow(title: 'cases', value: widget.cases.toString()),
                        ReUsableRow(title: 'todayDeaths', value: widget.todayDeaths.toString()),
                        ReUsableRow(title: 'recovered', value: widget.recovered.toString()),
                        ReUsableRow(title: 'active', value: widget.active.toString()),
                        ReUsableRow(title: 'critical', value: widget.critical.toString()),
                        ReUsableRow(title: 'todayRecovered', value: widget.todayRecovered.toString()),
                        ReUsableRow(title: 'tests', value: widget.tests.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
