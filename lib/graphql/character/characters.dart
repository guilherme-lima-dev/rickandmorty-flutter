class GetCharactersSchema {
  static String getCharactersSchema = """
    query Characters{
      characters{
        results{
          name
          species
          status
          gender
          image
        }
      }
    }
  """;
}