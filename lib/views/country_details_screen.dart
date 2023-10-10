import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  CountryDetailsScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovored,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      Key? key})
      : super(key: key);

  String name, image;
  int totalCases, totalDeaths, totalRecovored, active, critical, todayRecovered, test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.07),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
                        InfoRow(title: 'Cases', value: totalCases.toString()),
                        InfoRow(title: 'Recovered', value: totalRecovored.toString()),
                        InfoRow(title: 'Today Recovered', value: todayRecovered.toString()),
                        InfoRow(title: 'Active', value: active.toString()),
                        InfoRow(title: 'Critical', value: critical.toString()),
                        InfoRow(title: 'Tests', value: test.toString()),
                        InfoRow(title: 'Deaths', value: totalDeaths.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                )
              ],
            ),
          ],
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
