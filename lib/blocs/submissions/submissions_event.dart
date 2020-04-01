import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SubmissionsEvent extends Equatable {
  final String title;

  SubmissionsEvent({
    @required this.title,
  });

  @override
  List<Object> get props => [title];
}

class GetHotSubmissions extends SubmissionsEvent {
  GetHotSubmissions({
    title,
  }): super(
    title: title,
  );
}
class GetNewestSubmissions extends SubmissionsEvent {
  GetNewestSubmissions({
    title,
  }): super(
    title: title,
  );
}
class GetTopSubmissions extends SubmissionsEvent {
  GetTopSubmissions({
    title,
  }): super(
    title: title,
  );
}
class GetControversialSubmissions extends SubmissionsEvent {
  GetControversialSubmissions({
    title,
  }): super(
    title: title,
  );
}
