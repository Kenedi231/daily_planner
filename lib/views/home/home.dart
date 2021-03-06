part of home_view;

class _Home extends StatelessWidget {
  final HomeViewModel viewModel;

  _Home(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(i18n('Daily planner')),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        items: <Widget>[
          Icon(Icons.book, size: 30, color: Theme.of(context).iconTheme.color),
          Icon(Icons.list, size: 30, color: Theme.of(context).iconTheme.color),
          Icon(Icons.account_circle, size: 30, color: Theme.of(context).iconTheme.color),
        ],
        onTap: (index) => {
          viewModel.currentPage = index
        },
      ),
      body: PageView(
        physics: new NeverScrollableScrollPhysics(),
        controller: viewModel.pageController,
        children: viewModel.pageList,
      ),
    );
  }
}
