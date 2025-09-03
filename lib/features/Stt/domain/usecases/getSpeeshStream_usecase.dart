import 'package:choach_debate/features/Stt/domain/entities/stt_entity.dart';
import 'package:choach_debate/features/Stt/domain/repositories/stt_repository.dart';

class GetspeeshstreamUsecase {
  final SttRepository repository;

  GetspeeshstreamUsecase(this.repository);

  Stream<SttEntity> call() {
    return repository.onResult;
  }
}
