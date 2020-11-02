import 'package:flutter/material.dart';
import './data.dart';
import './network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma Code Test',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Data> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  TextEditingController searchController = TextEditingController();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: SafeArea(
          child: FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    margin: EdgeInsets.all(30),
                    child: Column(children: [
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchString = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.tags.length,
                          itemBuilder: (context, index) {
                            return snapshot.data.tags[index].displayName
                                        .contains(searchString) ||
                                    snapshot.data.tags[index].description
                                        .contains(searchString)
                                ? CardWidget(
                                    displayName:
                                        snapshot.data.tags[index].displayName,
                                    description:
                                        snapshot.data.tags[index].description,
                                    metatags: snapshot.data.tags[index].meta,
                                  )
                                : Container();
                          },
                        ),
                      ),
                    ]));
              }
              return Center(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator()),
              );
            },
          ),
        ));
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key key, this.description, this.displayName, this.metatags})
      : super(key: key);

  final String displayName;
  final String description;
  final String metatags;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 23,
                    color: Color(0xFFB15075),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              metatags,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: 15),
            Text(
              'Spaces',
              style: TextStyle(color: Color(0xFFB15075), fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
