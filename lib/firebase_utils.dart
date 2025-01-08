import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/model/event.dart';

import 'model/my_user.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(String uId){
    return getUsersCollection().doc(uId).
    collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot,_) => Event.fromFireStore(snapshot.data()),
      toFirestore: (event,_) => event.toFireStore(event),
    );
  }

  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),);
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async{
    var querySnapShot = await getUsersCollection().doc(id).get();
    return querySnapShot.data();
  }

  static Future<void> addEventToFireStore(Event event, String uId){
    var collectionRef = getEventCollection(uId);
    var docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }


  static Future<void> updateEventInFireStore(Event event, String uId){
    CollectionReference<Event> eventsOfUser = FirebaseUtils.getEventCollection(uId);
    return eventsOfUser.doc(event.id)
        .update(
        {
          'title' : event.title,
          'description' : event.description,
          'image' : event.image,
          'eventName' : event.eventName,
          'dateTime' : event.dateTime.millisecondsSinceEpoch,
          'time' : event.time,
        }
    ).then((value) => print("Event Updated Successfully"))
        .catchError((error) => print("Failed to update Event: $error"));
  }
  static Future<void> removeEventFromFireStore(String eventId, String uId){
    CollectionReference<Event> eventsOfUser = FirebaseUtils.getEventCollection(uId);
    return eventsOfUser.doc(eventId)
        .delete()
        .then((value) => print("Event Deleted Successfully"))
        .catchError((error) => print("Failed to Delete Event: $error"));
  }
}