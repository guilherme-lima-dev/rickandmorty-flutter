import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickmorty/ultils/url.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink(endpointUrl, defaultHeaders: {
      }),
      cache: GraphQLCache(store: HiveStore()),
    ));

    return _client;
  }
}