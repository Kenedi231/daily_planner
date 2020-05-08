part of todo_item_view;

class _TodoItem extends StatelessWidget {
  final TodoItemViewModel viewModel;
  final String heroTag;

  _TodoItem(this.viewModel, this.heroTag);

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: viewModel.formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 40),
                  child: Hero(
                    tag: heroTag == null ? viewModel.heroTag : heroTag,
                    child: Material(
                      color: Theme.of(context).backgroundColor,
                      child: TextFormField(
                        controller: viewModel.todoController,
                        decoration: InputDecoration(
                          labelText: i18n('Enter todo'),
                          labelStyle: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).buttonColor,
                            ),
                          ),
                        ),
                        autocorrect: true,
                        autofocus: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please, enter some text';
                          }
                          return null;
                        }
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Hero(
              tag: 'todo-button',
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  if (viewModel.formKey.currentState.validate()) {
                    print(viewModel.todoController.text);
                    viewModel.toBack();
                  }
                },
                child: Text(
                  i18n('Save'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
                elevation: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}