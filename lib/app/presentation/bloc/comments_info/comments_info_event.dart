import 'package:meta/meta.dart';

abstract class CommentsInfoEvent {}

class UpVoteComment extends CommentsInfoEvent {}
class DownVoteComment extends CommentsInfoEvent {}
