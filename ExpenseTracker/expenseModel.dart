import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ExpenseModel{
  int? id;
  DateTime date;
  double amount;
  String note;
  String category;

  ExpenseModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'category': category,
      'note': note,
    };
  }

  // Create from Map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date'].toString()),
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      note: map['note'] as String,
    );
  }

}

class ExpenseHandler{
  static Future <void> saveExpense(List<ExpenseModel> expense) async{
    //covert list of objects to list of map
    //convert list of map to json
    //save json to file

    final expenseMaps = expense.map((expense)=> expense.toMap()).toList();

    final jsonData= jsonEncode(expenseMaps);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/expense.json');
    await file.writeAsString(jsonData);
  }

  static Future<List<ExpenseModel>> loadExpense() async{
    //get file path
    //load json from file
    //convert json to list of map
    //convert list lof map to list of objects

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/expense.json');

    if( await file.exists() ){
      final data = await file.readAsString();

      final List<dynamic> expenseMaps=jsonDecode(data);

      return expenseMaps.map((map) => ExpenseModel.fromMap(map as Map<String, dynamic>)).toList();
    }
    else{
      return [];
    }
  }
}


