class Task {
  int? id;
  String? title;
  String? description;
  int? status;

  Task({this.title, this.description, this.status});

  Task.fromMap(Map<String, dynamic> tasks) {
    id = tasks['id'];
    title = tasks['title'];
    description = tasks['description'];
    status = tasks['status'];
  }

  Map<String, dynamic> toMapWithId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = null;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;

    return data;
  }
}
