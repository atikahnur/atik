
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Movie App',
        home: const MyHomePage(title: 'Flutter Movie 2u'),
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectMov = "Local";
  List<String> MovList = [
    "Local",
    "Comedies",
    "Crime",
    "Horror",
    "Romance",
  ];
  var desc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Simple Movie App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            DropdownButton(
              itemHeight: 60,
              value: selectMov,
              onChanged: (newValue) {
                setState(() {
                  selectMov = newValue.toString();
                });
              },
              items: MovList.map((selectMov) {
                return DropdownMenuItem(
                  value: selectMov,
                  child: Text(
                    selectMov,
                  ),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _getGenre, child: const Text("Load Movie")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ]),
        ));
  }

  Future<void> _getGenre() async {
    var apikey = "12d5b34";
    var url = Uri.parse('http://www.omdbapi.com/?t=$selectMov&apikey=$apikey');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedjson = json.decode(jsonData);
      setState(() {
        var genre = parsedjson["Genre"];

        desc = "search result for genre $genre";
      });
    } else {
      setState(() {
        desc = "no result";
      });
    }
  }
}
