
import 'package:examen_practic_sim/screens/form_screen.dart';
import 'package:examen_practic_sim/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/user_screen.dart';


Map<String, WidgetBuilder> getRoutes(){
 return <String, WidgetBuilder>{
       '/': (BuildContext context) => HomeScreen(),
       '/user': (BuildContext context) => UserScreen(user: null,),
       '/form': (BuildContext context) => FormScreen(),
     };
}