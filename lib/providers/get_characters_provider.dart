import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickmorty/endpoints.dart';
import 'package:rickmorty/graphql/character/characters.dart';
import 'package:rickmorty/models/character.dart';

class GetCharactersProvider extends ChangeNotifier {
  bool _status = false;
  String _response = '';
  List _list = [];
  bool get getStatus => _status;
  String get getResponse => _response;
  final EndPoint _point = EndPoint();
  bool loading = false;

  void setLoading(){
    loading = !loading;
    notifyListeners();
  }

  void getCharacters(bool isLocal) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(
      QueryOptions(
        document: gql(GetCharactersSchema.getCharactersSchema),
        fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      // check if we have any exception
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Erro de conexão com a internet";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _status = false;
      _list = (result.data!['characters']['results']! as List?)!;

      notifyListeners();
    }
  }

  List<Character?> getCharactersData() {
    if (_list.isNotEmpty) {
      List<Character>? data;
      data = _list.map((data) => Character.fromJson(data)).toList();
      return data;
    } else {
      return [];
    }
  }

  void clearResponse() {
    _response = '';
    notifyListeners();
  }
}