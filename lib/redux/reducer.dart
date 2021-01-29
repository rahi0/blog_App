
import 'package:blogApp/redux/actions.dart';
import 'package:blogApp/redux/states.dart';

AppState reducer(AppState state, dynamic action){

  if(action is HomeInfoAction){
    return state.copywith(
      homeInfoState: action.homeInfoAction  ///// your updating list where you store by applying logic 
    );
  } 
  

  return state;
} 
