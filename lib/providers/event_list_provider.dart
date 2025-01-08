import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../firebase_utils.dart';

class EventListProvider extends ChangeNotifier{
  int selectedIndex = 0 ;
  List<Event> filterList = [];
  List<Event> eventsList = [];
  List<Event> favoriteList = [];
  List<String> eventKeyNameList = [
    'Sport',
    'Birthday',
    'Meeting',
    'Holiday',
    'Exhibition',
    'Book Club',
    'Gaming',
    'Eating',
    'Workshop',
  ];
  Event? event;


  void getAllEvents(String uId) async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
          (doc) {
        return doc.data();
      },
    ).toList();
    filterList = eventsList;
    filterList.sort((Event event1, Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

  }

  void getFilterEvents(String uId) async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
          (doc) {
        return doc.data();
      },
    ).toList();
    filterList = eventsList.where((event){
      return event.eventName == eventKeyNameList[selectedIndex - 1];
    }).toList();
    filterList.sort((Event event1, Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

  }

  void changeSelectedIndex(int newSelectedIndex, String uId){
    selectedIndex = newSelectedIndex;
    if(selectedIndex == 0){
      getAllEvents(uId);
    }
    else{
      getFilterEvents(uId);
    }
  }


  void updateFavoriteEventState(Event event, String uId) async{
    CollectionReference<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId);
    event.isFavorite = !event.isFavorite;
    querySnapshot.doc(event.id).
    update({"isFavorite" : event.isFavorite});
    getFavoriteEvents(uId);
  }

  void getFavoriteEvents(String uId) async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
          (doc) {
        return doc.data();
      },
    ).toList();
    favoriteList = eventsList.where((event){
      return event.isFavorite == true;
    }).toList();
    notifyListeners();

  }
}
