import 'package:event_planning/model/event.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier{
  Event? event;

  void updateEvent(Event newEvent){
    event = newEvent;
    notifyListeners();
  }
}