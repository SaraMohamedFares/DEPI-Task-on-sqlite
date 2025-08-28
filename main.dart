import 'package:depi/ExpenseTracker/home_Screen.dart';
import 'package:depi/ExpenseTracker/sqflite.dart';
import 'package:depi/burger.dart';
import 'package:depi/cartModel.dart';
import 'package:depi/cart_Cubit.dart';
import 'package:depi/catalog_Screen.dart';
import 'package:depi/categories.dart';
import 'package:depi/gestureLayout.dart';
import 'package:depi/home_Page.dart';
import 'package:depi/layout.dart';
import 'package:depi/login.dart';
import 'package:depi/musicPlayer.dart';
import 'package:depi/photoGallary.dart';
import 'package:depi/products.dart';
import 'package:depi/profile.dart';
import 'package:depi/profileCard.dart';
import 'package:depi/provider_Ex.dart';
import 'package:depi/small_App/advanced_Bottom_Navbar.dart';
import 'package:depi/swap_Puzzle.dart';
import 'package:depi/taskTracker.dart';
import 'package:depi/transformGesture.dart';
import 'package:depi/wishlistModel.dart';
import 'package:depi/wishlist_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDatabase.initDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

