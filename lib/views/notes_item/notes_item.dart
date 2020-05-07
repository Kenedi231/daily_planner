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
              child: Icon(Icons.done, size: 30, color: Theme.of(context).textTheme.title.color)
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
                children: <Widget>[
                  Icon(Icons.bookmark_border),
                  SizedBox(width: 10),
                  DropdownButton(
                    value: viewModel.currentValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    dropdownColor: Theme.of(context).primaryColor,
                    isExpanded: false,
                    onChanged: (String newValue) {
                      viewModel.setCurrentValue = newValue;
                    },
                    underline: SizedBox(height: 0),
                    items: viewModel.categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)
                      );
                    }).toList(),
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