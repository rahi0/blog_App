class AppState {
 

  ///  state where you want to store
  var homeInfoState; 
 


  AppState(
      {
       this.homeInfoState,
      });

  AppState copywith(
      {homeInfoState}) {


    return AppState(
      homeInfoState: homeInfoState ?? this.homeInfoState,
     
    );
  }
}
