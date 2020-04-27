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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          locator<NavigatorService>().navigateToTODOItem();
        },
        child: Icon(Icons.add, size: 40, color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'todo-button',
      ),
    );
  }
}