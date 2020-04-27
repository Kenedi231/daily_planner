part of todo_item_view;

class _TodoItem extends StatelessWidget {
  final TodoItemViewModel viewModel;

  _TodoItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Text('Add new todo'),
          Hero(
            tag: 'todo-button',
            child: RaisedButton(
              onPressed: () {
                locator<NavigatorService>().pop();
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}