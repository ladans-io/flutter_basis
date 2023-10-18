const errPattern = 'Could not find a generator for route';

String getNavigationErrorPrettly(String err, {String? route}) {
  if (err.toLowerCase().contains(errPattern.toLowerCase())) {
    return "Route '$route' not found. Make sure you have registered on [basisRoute] yet!";
  } else {
    return err;
  }
}