import 'package:covid19_tracker/services/states_services.dart';
import 'package:covid19_tracker/views/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);
  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  late StatesServices _services;
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    _services = StatesServices();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Countries List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.white,
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
              ),
              FutureBuilder(
                future: _services.fetchCountriesList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(width: 80, height: 50, color: Colors.white),
                                  title: Container(width: 80, height: 10, color: Colors.white),
                                  subtitle: Container(width: 80, height: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  child: ListTile(
                                    leading: Image(
                                      width: 50,
                                      height: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CountryDetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          totalRecovored: snapshot.data![index]['recovered'],
                                          test: snapshot.data![index]['tests'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image(
                                    width: 50,
                                    height: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                ),
                              ],
                            );
                          } else {
                            return Container();
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
      ),
    );
  }
}
