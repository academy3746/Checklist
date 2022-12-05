// Index Page
import 'package:checklist/data/util.dart';
import 'package:checklist/write.dart';
import 'package:flutter/material.dart';

import 'data/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Test Data
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar를 삭제할 시 Body가 Demo 최상단에서부터 시작함...
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Page Redirection 추가 예정!
          // 1. write.dart
          Todo todo = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => TodoWritePage(
                todo: Todo(
                    title: "",
                    memo: "",
                    category: "",
                    color: 0,
                    done: 0,
                    date: Utils.getFormatTime(DateTime.now())),
              ),
            ),
          );

          setState(() {
            todos.add(todo);
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: const Text(
                "오늘 하루",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          } else if (idx == 1) {
            List<Todo> undone = todos.where((t) {
              return t.done == 0;
            }).toList();

            return Column(
              children: List.generate(undone.length, (idx) {
                Todo t = undone[idx];
                return InkWell(
                  child: TodoCardWidget(t),
                  onTap: () {
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {
                    Todo todo = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => TodoWritePage(todo: t),
                      ),
                    );
                    setState(() {});
                  },
                );
              }),
            );
          } else if (idx == 2) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: const Text(
                "완료된 하루",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          } else if (idx == 3) {
            List<Todo> done = todos.where((t) {
              return t.done == 1;
            }).toList();

            return Column(
              children: List.generate(done.length, (idx) {
                Todo t = done[idx];
                return InkWell(
                  child: TodoCardWidget(t),
                  onTap: () {
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {
                    Todo todo = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => TodoWritePage(todo: t),
                      ),
                    );
                    setState(() {});
                  },
                );
              }),
            );
          }

          return Container();
        },
        itemCount: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined), label: "오늘"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
        ],
      ),
    );
  }
}

class TodoCardWidget extends StatelessWidget {
  final Todo t;

  TodoCardWidget(this.t, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Color(t.color), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                t.done == 0 ? "미완료" : "완료",
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Container(height: 12),
          Text(
            t.memo,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
