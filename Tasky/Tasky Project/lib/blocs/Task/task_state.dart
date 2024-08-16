part of 'task_bloc.dart';

class TaskState extends Equatable {
  final File? taskImg;
  final bool isLoading;
  final TextEditingController title;
  final TextEditingController dscrp;
  final GlobalKey<FormState> formKey;
  final TextEditingController date;
  final String? priority;
  final String? status;
  TaskState({
    required this.isLoading,
    TextEditingController? title,
    GlobalKey<FormState>? formKey,
    TextEditingController? dscrp,
    TextEditingController? date,
    this.taskImg,
    this.status,
    this.priority,
  })  : title = title ?? TextEditingController(),
        dscrp = dscrp ?? TextEditingController(),
        date = date ?? TextEditingController(),
        formKey = formKey ?? GlobalKey<FormState>();

  TaskState copyWith({
    bool? isLoading,
    TextEditingController? title,
    GlobalKey<FormState>? formKey,
    TextEditingController? dscrp,
    TextEditingController? date,
    File? taskImg,
    String? priority,
    String? status,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      dscrp: dscrp ?? this.dscrp,
      date: date ?? this.date,
      formKey: formKey ?? this.formKey,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      taskImg: taskImg ?? this.taskImg,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        title,
        dscrp,
        formKey,
        date,
        taskImg,
        priority,
      ];
}

class TaskLoading extends TaskState {
  TaskLoading({
    required super.isLoading,
    super.title,
    super.dscrp,
    super.date,
    super.formKey,
    super.taskImg,
    super.priority,
  });
}

class TaskError extends TaskState {
  TaskError({
    required super.isLoading,
    super.title,
    super.dscrp,
    super.date,
    super.formKey,
    super.taskImg,
    super.priority,
  });
}

class TaskLoaded extends TaskState {
  final TaskModel taskDetails;

  TaskLoaded({
    required this.taskDetails,
    required super.isLoading,
    super.title,
    super.dscrp,
    super.date,
    super.formKey,
    super.taskImg,
    super.priority,
    super.status,
  });

  @override
  TaskLoaded copyWith({
    TaskModel? taskDetails,
    bool? isLoading,
    TextEditingController? title,
    GlobalKey<FormState>? formKey,
    TextEditingController? dscrp,
    TextEditingController? date,
    File? taskImg,
    String? priority,
    String? status,
  }) {
    return TaskLoaded(
      taskDetails: taskDetails ?? this.taskDetails,
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      dscrp: dscrp ?? this.dscrp,
      date: date ?? this.date,
      formKey: formKey ?? this.formKey,
      taskImg: taskImg ?? this.taskImg,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}
