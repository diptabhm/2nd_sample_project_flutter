import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for UI
  late String time; //the time in that location
  late String flag; //url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime;



  WorldTime({required this.location,
             required this.flag,
             required this.url});

  Future<void> getTime() async {

    try {

      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties form data
      String datetime = data['datetime'];
      int offset = data['dst_offset'];

      // print(datetime);
      // print(offset);

      //dst_offset raw_offset datetime

      // create dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: offset));

      //set time property
      print(now.hour);
      isDaytime = now.hour >= 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

    } catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
    
  }

}