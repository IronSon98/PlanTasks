String? titleValidator(String? title) {
  if (title == null || title.isEmpty) {
    return 'Informe o título da tarefa.';
  }
  return null;
}

String? descriptionValidator(String? description) {
  if (description == null || description.isEmpty) {
    return 'Informe a descrição da tarefa.';
  }
  return null;
}
