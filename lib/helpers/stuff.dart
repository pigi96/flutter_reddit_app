import 'package:draw/draw.dart';

String checkForUrl(List<SubmissionPreview> submissionPreview) {
  String url = "";
  if (submissionPreview.length > 0) url = submissionPreview[0].source.url.toString();
  return url;
}