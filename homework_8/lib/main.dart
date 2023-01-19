import 'package:flutter/material.dart';

import 'fetch_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abdazim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Открыть файл 1'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotPage()));
              },
            ),
            ElevatedButton(
              child: Text('Открыть файл 2'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
              },
            ),
          ],
        )
      ),
    );
  }
}

class NotPage extends StatefulWidget {
  const NotPage({Key? key}) : super(key: key);

  @override
  State<NotPage> createState() => _NotPageState();
}

class _NotPageState extends State<NotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: FutureBuilder<String>(
        future: fetchFileFromAssets('assets/dataa.txt'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('NONE'),
              );
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              return SingleChildScrollView(child: Text('${snapshot.data}'));
              break;
            default:
              return SingleChildScrollView(
                child: Text('Default'),
              );
          }
        },
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _controller = TextEditingController();

  String? strAssets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.31,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      strAssets = _controller.text;
                    });
                  },
                  child: Text('найти'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(65, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder<String>(
              stream: getData(strAssets),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Text('NONE'),
                    );
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());

                  case ConnectionState.done:
                    return SingleChildScrollView(child: Text('${snapshot.data}'));

                  default:
                    return const Text('Default');
                }
              },
            ),
          ],
        ),
      )
    );
  }
}

