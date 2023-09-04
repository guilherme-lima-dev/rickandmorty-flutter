import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickmorty/providers/get_characters_provider.dart';
import 'package:rickmorty/ui/views/home/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetCharactersProvider()),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
