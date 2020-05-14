part of notes_item_view;

class _NotesItem extends StatelessWidget {
  final NotesItemViewModel viewModel;
  final String heroTag;

  _NotesItem(this.viewModel, this.heroTag);

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n('Note')),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Hero(
              tag: 'note-create',
              child: Icon(Icons.done, size: 30, color: Theme.of(context).textTheme.headline6.color)
            ),
            onPressed: viewModel.saveNote,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: viewModel.focusInput,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(viewModel.currentValue.icon, color: viewModel.currentValue.color),
                      DropdownDialog(viewModel: viewModel),
                    ],
                  ),
                  Text(
                    viewModel.dateFormating(viewModel.dateNow),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  child: Hero(
                    tag: heroTag ?? viewModel.heroTag,
                    child: Material(
                      color: Theme.of(context).backgroundColor,
                      child: TextField(
                        focusNode: viewModel.focusNode,
                        controller: viewModel.noteController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration.collapsed(hintText: i18n('Enter note')),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownDialog extends StatelessWidget {
  const DropdownDialog({
    Key key,
    @required this.viewModel,
  }) : super(key: key);
  final NotesItemViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return DropdownDialogWidget(
      items: viewModel.categories.map<DropdownMenuItem<CategoryModel>>((CategoryModel item) {
        return DropdownMenuItem<CategoryModel>(
          child: Row(
            children: <Widget>[
              Icon(item.icon, color: item.color),
              SizedBox(width: 10),
              Text(item.name),
            ],
          ),
          value: item,
        );
      }).toList(),
      selectedValue: viewModel.currentValue,
      onChanged: (value) async {
        if (value?.name == 'New') {
          viewModel.setCurrentValue = viewModel.currentValue;
          await showNewCategorySheet(context);
          viewModel.updateCategory();
        } else {
          viewModel.setCurrentValue = value ?? viewModel.currentValue;
        }
      },
    );
  }
}