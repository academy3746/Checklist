// Model
class Todo
{
  String title;
  String memo;
  String category;
  int color; // DB에 실제로 넘겨주는 값은 color가 아니라 정수 값!
  int done;
  int date;

  Todo({this.title, this.memo, this.category, this.color, this.done, this.date});
}