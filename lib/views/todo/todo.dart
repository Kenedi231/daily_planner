part of todo_view;

class _Todo extends StatelessWidget {
  final TodoViewModel viewModel;

  _Todo(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ListView.builder(
          itemCount: viewModel.todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Hero(
                tag: viewModel.todoList[index].heroTag,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    leading: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Theme.of(context).textTheme.body2.color,
                      ),
                      child: Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: viewModel.todoList[index].completed,
                        onChanged: (_) {
                          viewModel.switchStatus(index);
                        }
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        viewModel.removeItem(index);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).textTheme.body2.color,
                      ),
                    ),
                    title: Text(
                      viewModel.todoList[index].title,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.body2.color,
                      ),
                    ),
                    onTap: () {
                      viewModel.editItem(index);
                    },
                  ),
                ),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.createNewTodo();
        },
        child: Icon(Icons.add, size: 40, color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'todo-button',
      ),
    );
  }
}