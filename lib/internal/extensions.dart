import 'package:flutter/material.dart';

extension WeekNumber on DateTime {
  int get weekNumber {
    final startOfYear = DateTime(year, 1, 1, 0, 0);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    if (daysInFirstWeek > 3) {
      weeks += 1;
    }
    return weeks;
  }
}

extension Minutes on TimeOfDay {
  int get inMinutes {
    return hour * 60 + minute;
  }
}

extension Short on String {
  String get short {
    final List<String> consonants = [
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

    final String input = this;
    if (input.length <= 10) {
      return input;
    }

    if (input.length < 24 || input.split(' ').length < 3) {
      String output = '';
      final List<String> words = input.split(' ');

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
