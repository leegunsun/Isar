import 'package:decimal/decimal.dart';
import 'package:swf/decimal_cal.dart';

var TX_VALUE_DECIMAL_FIX = 18;

class DecimalHelper {

  String _str = '';

  get removeComma => DecimalCalculator.removeComma(_str);

  // String 타입의 숫자를 Decimal 타입으로 변환하는 메서드
  static Decimal encode(dynamic number) {
    if (number is! String) {
      number = number.toString();
    }

    return Decimal.parse(number);
  }

  // 서버에서 데이터를 받을 때 사용 -> 숫자를 String 타입으로 변환하는 메서드
  static String decode(dynamic number) {
    String str = number.toStringAsFixed(TX_VALUE_DECIMAL_FIX);

    List<String> newParts = str.split('.');
    String decimalPart = newParts[1];
    while (decimalPart.endsWith('0')) {
      decimalPart = decimalPart.substring(0, decimalPart.length - 1);
    }

    if (decimalPart.isEmpty) {
      return newParts[0];
    }
    return '${newParts[0]}.$decimalPart';
  }

  // 유저의 화면에 표현할 displayFormat ex) 1,000.000000000000000001  static String displayFormat(dynamic number) {
  displayFormat(dynamic number) {
    String str = number is! String ? number.toString() : number;
    String intPart = '';

    if (!str.contains('.')) {
      String reversedIntPart = intPart.split('').reversed.join();
      String formattedIntPart = RegExp(r'.{1,3}')
          .allMatches(reversedIntPart)
          .map((match) => match.group(0))
          .join(',');
      formattedIntPart = formattedIntPart.split('').reversed.join();

      return formattedIntPart;
    }

    // 정수 부분과 소수점 이하 부분으로 나눕니다.
    List<String> parts = str.split('.');

    // 정수 부분에 천 단위마다 쉼표를 추가합니다.
    intPart = parts[0];
    String reversedIntPart = intPart.split('').reversed.join();
    String formattedIntPart = RegExp(r'.{1,3}')
        .allMatches(reversedIntPart)
        .map((match) => match.group(0))
        .join(',');
    formattedIntPart = formattedIntPart.split('').reversed.join();

    if (parts.length > 1) {
      // 소수점 아래 부분이 18자리를 초과하면 18자리까지만 가져옵니다.
      if (parts[1].length > TX_VALUE_DECIMAL_FIX) {
        String truncated = parts[1].substring(0, TX_VALUE_DECIMAL_FIX);
        if (int.parse(parts[1][TX_VALUE_DECIMAL_FIX]) >= 5) {
          number = encode(number);
          Decimal increment = Decimal.parse('0.' + '0' * 17 + '1');
          number += increment;
          return decode(number); // 숫자를 수정한 후에 다시 format 함수를 호출합니다.
        }
        str = '$formattedIntPart.$truncated';
        _str = str;
      }

      // 끝이 0인 경우 제거합니다.
      List<String> newParts = str.split('.');
      String decimalPart = newParts[1];
      while (decimalPart.endsWith('0')) {
        decimalPart = decimalPart.substring(0, decimalPart.length - 1);
      }

      // 모든 숫자가 제거된 경우 소수점 아래 부분을 출력하지 않습니다.
      if (decimalPart.isEmpty) {
        _str = formattedIntPart;
        return formattedIntPart;
      }
      _str = '$formattedIntPart.$decimalPart';
      return '$formattedIntPart.$decimalPart';
    } else {
      _str = formattedIntPart;
      return formattedIntPart;
    }
  }
}
