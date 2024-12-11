abstract class FavouriteStates {}

class InitialState extends FavouriteStates {}

class SuccessAddToFavouriteState extends FavouriteStates {}

class LoadingAddToFavouriteState extends FavouriteStates {}

class FailureAddToFavouriteState extends FavouriteStates {
  final String message;

  FailureAddToFavouriteState({required this.message});
}

class SuccessDeleteOrAddToFavouriteState extends FavouriteStates {}

class LoadingDeleteOrAddToFavouriteState extends FavouriteStates {}

class FailureDeleteOrAddToFavouriteState extends FavouriteStates {
  final String message;

  FailureDeleteOrAddToFavouriteState({required this.message});
}
