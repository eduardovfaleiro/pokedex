// ignore_for_file: constant_identifier_names

const ERROR = PageState.error;
const SUCCESS = PageState.success;
const LOADING = PageState.loading;

enum PageState { error, success, loading }

mixin PageStateController {
  var _pageState = SUCCESS;

  void setPageState(PageState pageState) {
    _pageState = pageState;
  }

  bool get isOnError => _pageState == ERROR;
  bool get isSuccessful => _pageState == SUCCESS;
  bool get isLoading => _pageState == LOADING;
}
