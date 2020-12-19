extension StringShortner on String {
  String get short {
    List<String> consonants = [
      'б',
      'в',
      'г',
      'д',
      'ж',
      'з',
      'й',
      'к',
      'л',
      'м',
      'н',
      'п',
      'р',
      'с',
      'т',
      'ф',
      'х',
      'ц',
      'щ'
    ];

    String input = this;
    if (input.length <= 10) {
      return input;
    }

    if (input.length < 24 || input.split(' ').length < 3) {
      String output = '';
      List<String> words = input.split(' ');

      words.forEach((word) {
        if (word.length < 4) {
          output += word + ' ';
        } else {
          output += word.substring(0, 3);
          if (word.length > 4) {
            int i = 1;
            while (consonants.contains(word[i + 3])) {
              output += word[i + 3];
              i++;
            }
          }

          output += '. ';
        }
      });
      return output;
    }

    List<String> words = input.split(" ");
    String output = '';
    words.forEach((word) {
      output += word[0];
    });
    return output;
  }
}
