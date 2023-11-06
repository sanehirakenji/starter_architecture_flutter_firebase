import 'package:freezed_annotation/freezed_annotation.dart';
import '../../jobs/domain/job.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

typedef EntryID = String;

@Freezed()
class Entry with _$Entry {
  const Entry._();
  const factory Entry({
    required String id,
    required JobID jobId,
    required DateTime start,
    required DateTime end,
    required String comment,
  }) = _Entry;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic> value, EntryID id) {
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      jobId: value['jobId'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

}