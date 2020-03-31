import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SubmissionEvent extends Equatable {
  final String title;

  SubmissionEvent({
    @required this.title,
  });

  @override
  List<Object> get props => [title];
}

class LoadSubmissionsHot extends SubmissionEvent {
  LoadSubmissionsHot({
    title,
  }): super(
    title: title,
  );
}
class LoadSubmissionsNewest extends SubmissionEvent {
  LoadSubmissionsNewest({
    title,
  }): super(
    title: title,
  );
}
class LoadSubmissionsTop extends SubmissionEvent {
  LoadSubmissionsTop({
    title,
  }): super(
    title: title,
  );
}
class LoadSubmissionsControversial extends SubmissionEvent {
  LoadSubmissionsControversial({
    title,
  }): super(
    title: title,
  );
}
