class Todo {
  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String backgroundImage;
  final String backgroundImageSource;
  final String userName;
  final String userImage;
  final DateTime startDate;
  final DateTime dueDate;
  final double progress;
  final bool status;
  final String description;
  final List<Subtask> subtasks;
  final List<Comment> comments;

  Todo({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.backgroundImageSource,
    required this.userName,
    required this.userImage,
    required this.startDate,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.description,
    required this.subtasks,
    required this.comments,
  });

  // Decode JSON to Model
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      tag: json['tag'],
      title: json['title'],
      subtitle: json['subtitle'],
      backgroundImage: json['backgroundImage'],
      backgroundImageSource: json['backgroundImageSource'],
      userName: json['userName'],
      userImage: json['userImage'],
      startDate: DateTime.parse(json['startDate']),
      dueDate: DateTime.parse(json['dueDate']),
      progress: json['progress'].toDouble(),
      status: json['status'],
      description: json['description'],
      subtasks: (json['subtasks'] as List)
          .map((subtask) => Subtask.fromJson(subtask))
          .toList(),
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }
}

class Subtask {
  final String title;
  final bool status;

  Subtask({
    required this.title,
    required this.status,
  });

  // Decode JSON to Model
  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      title: json['title'],
      status: json['status'],
    );
  }
}

class Comment {
  final String id;
  final String profileImageUrl;
  final String comment;
  final String timestamp;

  Comment({
    required this.id,
    required this.profileImageUrl,
    required this.comment,
    required this.timestamp,
  });

  // Decode JSON to Model
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      profileImageUrl: json['profileImageUrl'],
      comment: json['comment'],
      timestamp: json['timestamp'],
    );
  }
}
