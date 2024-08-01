import 'package:flutter/material.dart';
import 'package:meals_app/models/category_model.dart';

class CategoryDummyData {
  final List<CategoryModel> avaialableCategories = [
    CategoryModel(id: '1', title: 'italian', color: Colors.purple,),
    CategoryModel(id: '2', title: 'german', color: Colors.yellow,),
    CategoryModel(id: '3', title: 'quick & easy', color: Colors.blue,),
    CategoryModel(id: '4', title: 'breakfast', color: Colors.green,),
    CategoryModel(id: '5', title: 'summer', color: Colors.grey,),
    CategoryModel(id: '6', title: 'exotic', color: Colors.redAccent,),
    CategoryModel(id: '7', title: 'asian', color: Colors.blueGrey,),
    CategoryModel(id: '8', title: 'french', color: Colors.black38,),
  ];
}