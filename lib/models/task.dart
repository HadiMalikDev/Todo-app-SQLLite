class Task{

  int id;
  String title;
  String description;
  int completed; //0 signals false whilst 1 signals true

  Task({this.id,this.title,this.description,this.completed=0});


  Map<String,dynamic> toJson(){
    return {
      'title':title,
      'description':description,
      'completed':completed,
    };
  }
}