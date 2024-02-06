import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');


// fetch a paginated records list
Future<void> getPeople() async {
  final resultList = await pb.collection('People').getList(
    page: 1,
    perPage: 50,
    filter: 'created >= "2022-01-01 00:00:00" && someField1 != someField2',
  );
}

Future<void> getFullPeople() async {
// you can also fetch all records at once via getFullList
  final records = await pb.collection('People').getFullList(
    sort: '-created',
  );
}

Future<void> getFirstPerson() async {
// or fetch only the first record that matches the specified filter
  final record = await pb.collection('People').getFirstListItem(
    'someField="test"',
    expand: 'relField1,relField2.subRelField',
  );
}