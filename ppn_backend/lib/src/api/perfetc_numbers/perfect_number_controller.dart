import 'package:ppn_backend/src/domain/entities/perfect_number_entity.dart';
import 'package:ppn_backend/src/domain/repositories/perfect_number_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Api(tag: 'Perfect Number', description: 'Perfect Number Controller')
@Controller('/perfectnumber')
class PerfectNumberController {
  final PerfectNumberRepository perfectNumberRepository;
  PerfectNumberController(this.perfectNumberRepository);

  @Get('/check')
  Future<PerfectNumberEntity> checkPerfectNumber(@Query() int number) async {
    return await perfectNumberRepository.isPerfect(number).getOrThrow();
  }

  @Get('/find')
  Future<List<PerfectNumberEntity>> findPerfectNumbersInRange(
    @Query() int start,
    @Query() int end,
  ) async {
    return await perfectNumberRepository.findInRange(start, end).getOrThrow();
  }
}
