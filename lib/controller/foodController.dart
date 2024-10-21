import 'package:cafem2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodController extends ChangeNotifier {
  static FoodController instance = FoodController.internal();
  FoodController.internal();
  factory FoodController() => instance;

  List<Map<String, dynamic>> FoodItems = [];

  fetchfooditem() async {
    FirebaseFirestore.instance
        .collection('FoodItems')
        .snapshots()
        .listen((snapshot) {
      FoodItems.clear();
      for (var doc in snapshot.docs) {
        logger.d(doc.data());
        FoodItems.add(doc.data());
        notifyListeners();
      }
    });
  }
}
