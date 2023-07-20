import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Budget Tracker',
        to: 0,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int to;
  const MyHomePage({super.key, required this.title, required this.to});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;
  void changeData() {
    value = true;
    return;
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.to;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(child: Text(widget.title)),
        ),
        body: Align(
            alignment: FractionalOffset.center,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.deepPurpleAccent),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Total :',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      '$total',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NextPage(income: total)));
                      },
                      tooltip: 'History',
                      child: const Icon(Icons.arrow_circle_down),
                    ),
                  ],
                ),
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            )));
  }
}

class NextPage extends StatefulWidget {
  final int income;

  NextPage({required this.income, Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int _currentIncome = 0;
  var expense = [];
  var cause = [];
  var causeText = TextEditingController();
  var expenseInt = TextEditingController();
  @override
  void initState() {
    super.initState();
    _currentIncome = widget.income;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'total : $_currentIncome',
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: 30.0,
              ),
              Text(
                cause[index],
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              Text(
                expense[index].toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _currentIncome -= int.parse(expense[index].toString());
                    expense.removeAt(index);
                    cause.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete),
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.amber,
            height: 4,
          );
        },
        itemCount: cause.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Center(
                      child: Text(
                        'New Entry',
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    content: Center(
                      child: Column(children: <Widget>[
                        TextField(
                            style: TextStyle(
                              color: Colors.deepPurple,
                            ),
                            controller: causeText,
                            decoration: InputDecoration(
                                hintText: 'enter the cause here',
                                hintStyle: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                      color: Colors.deepPurple,
                                    )))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                            style: TextStyle(
                              color: Colors.deepPurple,
                            ),
                            controller: expenseInt,
                            decoration: InputDecoration(
                                hintText: 'enter the expense here',
                                hintStyle: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                      color: Colors.deepPurple,
                                    ))))
                      ]),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL')),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            var ct = TextEditingController();
                            var et = TextEditingController();
                            expense.add(int.parse(expenseInt.text));
                            _currentIncome += int.parse(expenseInt.text);
                            cause.add(causeText.text);
                            expenseInt = et;
                            causeText = ct;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
    ;
  }
}
