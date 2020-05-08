part of todo_view;

class _Todo extends StatelessWidget {
  final TodoViewModel viewModel;

  _Todo(this.viewModel);

  Widget buildItem(BuildContext context, TodoItemModel item, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Hero(
          tag: item.heroTag,
          child: Card(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              leading: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Theme.of(context).textTheme.bodyText2.color,
                ),
                child: Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  value: item.completed,
                  onChanged: (_) {
                    viewModel.switchStatus(item);
                  }
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  viewModel.removeItem(item, buildItem);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ),
              onTap: () {
                viewModel.editItem(item);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: AnimatedList(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
          key: viewModel.todoListKey,
          controller: viewModel.todoListController,
          initialItemCount: viewModel.todoList.length,
          itemBuilder: (context, index, animation) {
            return buildItem(context, viewModel.todoList[index], animation);
          }
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: viewModel.floatingActionButtonVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            viewModel.createNewTodo();
          },
          child: Icon(Icons.add, size: 40, color: Theme.of(context).iconTheme.color),
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: 'todo-button',
        ),
      ),
    );
  }
}