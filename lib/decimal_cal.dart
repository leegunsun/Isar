import 'package:decimal/decimal.dart';

import 'decimal.dart';


class DecimalCalculator {
  static Decimal? add(dynamic aStr, dynamic bStr) {
    try {

      Decimal a = DecimalHelper.encode(aStr);
      Decimal b = DecimalHelper.encode(bStr);

      Decimal result = a + b;

      if (result < Decimal.zero) {
        throw Exception('Negative result not allowed.');
      }
      return result;
    } catch (_) {
      return null;
    }
  }

  static Decimal? subtract(dynamic aStr, dynamic bStr) {
    try {

      Decimal a = DecimalHelper.encode(aStr);
      Decimal b = DecimalHelper.encode(bStr);

      Decimal result = a - b;

      if (result < Decimal.zero) {
        throw Exception('Negative result not allowed.');
      }
      return result;
    } catch (_) {
      return null;
    }
  }

  static String removeComma(dynamic number) {

    return number.toString().replaceAll(',', '');
  }

  static Decimal? multiply(dynamic aStr, dynamic bStr) {
    try {

      Decimal a = DecimalHelper.encode(aStr);
      Decimal b = DecimalHelper.encode(bStr);

      Decimal result = a * b;

      if (result < Decimal.zero) {
        throw Exception('Negative result not allowed.');
      }
      return result;
    } catch (_) {
      return null;
    }
  }

  static Decimal? divide(dynamic aStr, dynamic bStr) {
    try {

      Decimal a = DecimalHelper.encode(aStr);
      Decimal b = DecimalHelper.encode(bStr);

      if (a == Decimal.fromInt(0) || b == Decimal.fromInt(0)) {
        throw Exception('Division by zero is not allowed.');
      }

      // '유한 정밀도'로 결과를 Decimal 타입으로 변환
      Decimal result = (a / b).toDecimal(scaleOnInfinitePrecision: 18);

      if (result < Decimal.zero) {
        throw Exception('Negative result not allowed.');
      }
      return result;
    } catch (_) {
      return null;
    }
  }


  ///////////////////////////////////////////  ///////////////////////////////////////////  ///////////////////////////////////////////


  static Decimal? nm (dynamic totalSket, dynamic sketRateTotal, dynamic rate) {

    try {

      Decimal? a = subtract(totalSket, sketRateTotal)! * DecimalHelper.encode(rate);
      Decimal? result = divide(a, "100");

      return result;

    } catch (_) {
      return null;
    }
  }

  static Decimal? sketcoinToWon_krw (dynamic sketcoinStr, dynamic last, dynamic basePrice) {

    // ORIGINAL
    // var krw = double.parse(sketcoinStr) * double.parse(sketchToDollarModel!.last!) * exchangeRateModel!.basePrice!;
    try {

      Decimal? result = DecimalHelper.encode(sketcoinStr) * DecimalHelper.encode(last) * DecimalHelper.encode(basePrice);

      if (result < Decimal.zero) {
        throw Exception('Negative result not allowed.');
      }

      return result;
    } catch (_) {
      return null;
    }
  }

  static Decimal? sketcoinToWon_usd (dynamic sketcoinStr, dynamic last) {

    // ORIGINAL
    // var usd = double.parse(sketcoinStr) * double.parse(sketchToDollarModel!.last!);
    try {

      Decimal? result = multiply(sketcoinStr, last);

      return result;

    } catch (_) {
      return null;
    }
  }

  static Decimal? wonToSketcoin (dynamic wonStr, dynamic basePrice, dynamic last) {

    // ORIGINAL
    // (double.parse(wonStr) / (exchangeRateModel!.basePrice ?? 1.0)) * (1.0 / double.parse(sketchToDollarModel!.last ?? '1.0'));
    try {

      Decimal? a = divide(wonStr, (basePrice ?? 1.0));
      Decimal? b = divide(1.0, (last ?? 1.0));
      var result = multiply(a, b);

      return result;

    } catch (_) {
      return null;
    }
  }

  static Decimal? usdToSketcoin (dynamic usdStr, dynamic last) {

    // ORIGINAL
    // double.parse(usdStr) * (1.0 / double.parse(sketchToDollarModel!.last ?? '1.0'))
    try {

      Decimal? result = DecimalHelper.encode(usdStr) * divide(1.0, (last ?? 1.0))!;

      return result;

    } catch (_) {
      return null;
    }
  }

}