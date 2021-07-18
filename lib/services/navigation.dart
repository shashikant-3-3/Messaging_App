
import 'package:flutter/material.dart'; 
import 'package:flutter/widgets.dart';


class NavigationService { 
  late GlobalKey <NavigatorState> navigatorkey;

  static NavigationService instance = NavigationService();

  NavigationService() {

    navigatorkey = GlobalKey<NavigatorState>();

  }

  Future<dynamic>navigateToReplacement(String _routeName) { 
    return navigatorkey.currentState!.pushReplacementNamed (_routeName);

  }

  Future<dynamic>navigateToPage(String _routeName) { 
    return navigatorkey.currentState!.pushNamed (_routeName);

  }

  Future<dynamic>navigateToRoute(MaterialPageRoute _route){
    return navigatorkey.currentState!.push(_route);
  }

  void goBack(){
    return navigatorkey.currentState!.pop();
  }
}