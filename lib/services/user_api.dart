import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_series/model/user.dart';
import 'package:rest_api_series/model/user_dob.dart';
import 'package:rest_api_series/model/user_name.dart';
import 'package:rest_api_series/model/user_location.dart';

class UserApi {
  static Future<List<User>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      final date = e['dob']['date'];
      final dob = UserDob(
        age: e['dob']['age'],
        date: DateTime.parse(date),
      );
      final coordinates = LocationCoordinate(
        latitude: e['location']['coordinates']['latitude'],
        longitude: e['location']['coordinates']['longitude'],
      );

      final street = LocationStreet(
        name: e['location']['street']['name'],
        number: e['location']['street']['number'],
      );

      final timezone = LocationTimezone(
        description: e['location']['timezone']['description'],
        offset: e['location']['timezone']['offset'],
      );

      final location = UserLocation(
        city: e['location']['city'],
        country: e['location']['country'],
        // Some post codes are strings
        postcode: e['location']['postcode'].toString(),
        state: e['location']['state'],
        coordinates: coordinates,
        street: street,
        timezone: timezone,
      );

      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name: name,
        dob: dob,
        location: location,
      );
    }).toList();
    return users;
  }
}
