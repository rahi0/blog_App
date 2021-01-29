import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CallApi{

  //////////// Server Database /////////////////////  
    final String _url = 'https://crudcrud.com/api/661595aaf7c348cabf4d9227fef6ed5b/';
 

        withoutTokenPostData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
        //  print(await _setHeaders());
        print("full url is : $fullUrl");
        return await http.post(
            fullUrl, 
            body: jsonEncode(data), 
            headers: await _setwithoutTokenHeaders()
        );
    }


    deleteData(apiUrl) async {
        var fullUrl = _url + apiUrl;
        //  print(await _setHeaders());
        print("full url is : $fullUrl");
        return await http.delete(
            fullUrl, 
           // body: jsonEncode(data), 
           // headers: await _setwithoutTokenHeaders()
        );
    }

    putData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
        //  print(await _setHeaders());
        print("full url is : $fullUrl");
        return await http.put(
            fullUrl, 
            body: jsonEncode(data), 
            headers: await _setwithoutTokenHeaders()
        );
    }

       withoutTokengetData(apiUrl) async {
       var fullUrl = _url + apiUrl;
       print(fullUrl);
       return await http.get(
         fullUrl, 
         headers:  await _setwithoutTokenHeaders()
       );
    }
    
    _setwithoutTokenHeaders() async => {
      
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
    };

}