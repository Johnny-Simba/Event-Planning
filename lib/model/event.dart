class Event{
  static const String collectionName = 'Events';

  String id;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;

  Event({this.id = '', required this.title, required this.description, required this.image,
    required this.eventName, required this.dateTime, required this.time, this.isFavorite = false
  });
  // json => object
  Event.fromFireStore(Map<String, dynamic>? data):this(
    id: data!['id'],
    title: data['title'],
    description: data['description'],
    image: data['image'],
    eventName: data['eventName'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    time: data['time'],
    isFavorite: data['isFavorite'],
  );

  // object => json
  Map<String, dynamic> toFireStore(Event event){
    return{
      'id' : id,
      'title' : title,
      'description' : description,
      'image' : image,
      'eventName' : eventName,
      'dateTime' : dateTime.millisecondsSinceEpoch,
      'time' : time,
      'isFavorite' : isFavorite,
    };
  }
}