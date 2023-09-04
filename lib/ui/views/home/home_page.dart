import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rickmorty/models/character.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty/providers/get_characters_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var charactersProvider = context.read<GetCharactersProvider>();

      charactersProvider.setLoading();
      charactersProvider.getCharacters(false);
      charactersProvider.setLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    final charactersProvider = context.watch<GetCharactersProvider>();
    final List<Character?> characters = charactersProvider.getCharactersData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA0EB01),
        title: const Text("Rick and Morty",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 30)),
        centerTitle: true,
      ),
      body: charactersProvider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: 290,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  characters[index]?.image ?? "",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      characters[index]?.name ?? "---",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(" - "),
                                    Text(
                                      characters[index]?.species ?? "---",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    characters[index]?.gender ?? "---",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Text(" - "),
                                  Text(
                                    characters[index]?.status ?? "---",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                        color:
                                            characters[index]?.status == 'Alive'
                                                ?
                                                  Colors.green
                                                : characters[index]?.status == 'unknown' ?
                                                  Colors.yellow
                                                : Colors.red,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 264,
                ),
              ),
            ),
    );
  }
}
