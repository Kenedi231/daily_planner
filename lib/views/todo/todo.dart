part of todo_view;

class _Todo extends StatelessWidget {
  final TodoViewModel viewModel;

  _Todo(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Text('Todo')
      ),
    );
  }
}