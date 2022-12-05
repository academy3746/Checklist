// StatefulWidget: 사용자에 의해 변경이 가능한 페이지 (위젯)

import 'package:flutter/material.dart';
import 'data/todo.dart';

class TodoWritePage extends StatefulWidget {
  final Todo todo;

  const TodoWritePage({Key key, this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodoWritePageState();
  }
}

// 실제로 작성하는 위젯 페이지
class _TodoWritePageState extends State<TodoWritePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  int colorIndex = 0;
  int cateIndex = 0;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // 페이지 저장 (글 작성 완료) 시 사용!
              widget.todo.title = nameController.text;
              widget.todo.memo = memoController.text;

              Navigator.of(context).pop(widget.todo);
            },
            child: const Text(
              "저장",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text(
                "제목",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (idx == 1) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nameController,
              ),
            );
          } else if (idx == 2) {
            return InkWell(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "색상",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      color: Color(widget.todo.color),
                    )
                  ],
                ),
              ),
              onTap: () {
                List<Color> colors = [
                  const Color(0xFF80d3f4),
                  const Color(0xFFa794fa),
                  const Color(0xFFfb91d1),
                  const Color(0xFFfb8a94),
                  const Color(0xFFfebd9a),
                  const Color(0xFF51e29d),
                  const Color(0xFFFFFFFF),
                ];

                widget.todo.color = colors[colorIndex].value;
                // 내부 순환 루프
                colorIndex++;

                setState(() {
                  colorIndex = colorIndex % colors.length;
                });
              },
            );
          } else if (idx == 3) {
            return InkWell(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "카테고리",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(widget.todo.category)
                  ],
                ),
              ),
              onTap: () {
                List<String> category = ["공부", "운동", "취미", "예배"];

                widget.todo.category = category[cateIndex];
                // 내부 순환 루프
                cateIndex++;

                setState(() {
                  cateIndex = cateIndex % category.length;
                });
              },
            );
          } else if (idx == 4) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text(
                "메모",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (idx == 5) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: TextField(
                controller: memoController,
                maxLines: 10,
                minLines: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            );
          }

          return Container();
        },
        itemCount: 6,
      ),
    );
  }
}
