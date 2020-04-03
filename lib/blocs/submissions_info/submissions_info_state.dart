import 'package:draw/draw.dart';

abstract class SubmissionsInfoState {
  Submission submission;
  SubmissionsInfoState(this.submission);
}

class InitialSubmissionsInfoState extends SubmissionsInfoState {
  InitialSubmissionsInfoState(submission):super(submission);
}

class SubmissionInfo extends SubmissionsInfoState {
  SubmissionInfo(submission):super(submission);
}