import 'package:vaden/vaden.dart';

@Api(tag: 'Perfect Number', description: 'Perfect Number Controller')
@Controller('/perfectnumber')
class PerfectNumberController {
  //localhost:8080/perfectnumber/check?number=28
  @Get('/check')
  String checkPerfectNumber(@Query() int number) {
    if (number < 1) {
      return 'Please enter a positive integer.';
    }

    int sum = 0;
    for (int i = 1; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        sum += i;
      }
    }

    if (sum == number) {
      return '$number is a perfect number.';
    } else {
      return '$number is not a perfect number.';
    }
  }
}
