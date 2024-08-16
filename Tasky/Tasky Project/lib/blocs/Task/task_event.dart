part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadImage extends TaskEvent {}

class ChangePriority extends TaskEvent {
  final String priority;
  ChangePriority({required this.priority});
}

class ChangeDate extends TaskEvent {}

class ChangeStatus extends TaskEvent {
  final String status;
  ChangeStatus({required this.status});
}

class UploadTask extends TaskEvent {
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  UploadTask({
    required this.desc,
    required this.priority,
    required this.dueDate,
    required this.title,
  });
}

class Task extends TaskEvent {}

class RemoveTask extends TaskEvent {
  final String iD;
  RemoveTask({required this.iD});
}

class UpdateTask extends TaskEvent {
  final String iD;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  UpdateTask({
    required this.iD,
    required this.image,
    required this.desc,
    required this.priority,
    required this.status,
    required this.title,
    required this.user,
  });
}

class TaskLoadingData extends TaskEvent {
  final String iD;
  TaskLoadingData({required this.iD});
}

class RefreshTokenEvent extends TaskEvent {}
