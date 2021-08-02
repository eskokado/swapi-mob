import 'dart:convert';

import 'package:http/http.dart' as http;

///
/// A class representing the SWAP API
/// 
class SWAPI {

 final String _endpoint = "http://10.0.2.2:5000";
 
  /// Common method to invoke the HTTP request
  _callAPI(url) async {
    String restURL = "$url?format=json";
    print(" URL call: $restURL");
    return await http.get(Uri.encodeFull(restURL), headers: {"Content-type": "application/json", 'charset':'utf-8'});
  }

  /// An example of using a specific API method
  getRoot() async {
    return _callAPI("$_endpoint/");
  }

  /// Generic Call using URL from API result
  getRawDataFromURL(url) async {
    return await _callAPI(url);
  }

 Future<http.Response> create(var data, String controller) async {
   data.remove('id');
   data.remove('created');
   data.remove('edited');
   data.remove('url');
   String restURL = "$_endpoint/$controller";
   print(" URL call post: $restURL");
   Object obj = jsonEncode(data);
   http.Response res = await http.post(
     Uri.encodeFull(restURL),
     headers: {"Content-type": "application/json", 'charset':'utf-8'},
     body: obj
   );
   return res;
 }

 Future<http.Response> update(var data, String controller) async {
    String id = data['id'];
    data.remove('id');
    data.remove('created');
    data.remove('edited');
    data.remove('url');
    String restURL = "$_endpoint/$controller/$id";
    print(" URL call put: $restURL");
    Object obj = jsonEncode(data);
    http.Response res = await http.put(
        Uri.encodeFull(restURL),
        headers: {"Content-type": "application/json", 'charset':'utf-8'},
        body: obj
    );
    return res;
 }

 Future<void> delete(String id, String controller) async {
   String restURL = "$_endpoint/$controller/$id";
   print(" URL call delete: $restURL");
   await http.delete(
       Uri.encodeFull(restURL),
       headers: {"Content-type": "application/json", 'charset':'utf-8'},
   );
 }
}
