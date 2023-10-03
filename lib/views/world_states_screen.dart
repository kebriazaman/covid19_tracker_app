import 'dart:async';

import 'package:covid19_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list_screen.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final StatesServices _statesServices;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
    _statesServices = StatesServices();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorldStatesScreen(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: FutureBuilder(
            future: _statesServices.fetchWorldSatesRecords(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50,
                  controller: _controller,
                );
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        'total': double.parse(snapshot.data!.cases.toString()),
                        'Recovered': double.parse(snapshot.data!.recovered.toString()),
                        'Deaths': double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                      legendOptions: LegendOptions(legendPosition: LegendPosition.left),
                      chartRadius: MediaQuery.sizeOf(context).width / 2,
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: Card(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                InfoRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                InfoRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                InfoRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                InfoRow(title: 'Active', value: snapshot.data!.active.toString()),
                                InfoRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                InfoRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                InfoRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountriesListScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xff1aa260),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Text('Track Countries'),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  String title, value;
  InfoRow({Key? key, required this.title, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toString()),
              Text(value.toString()),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          Divider(),
        ],
      ),
    );
  }
}
