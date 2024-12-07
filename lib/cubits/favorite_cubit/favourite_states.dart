abstract class FavouriteStates {}

class InitialState extends FavouriteStates {}

class SuccessAddToFavouriteState extends FavouriteStates {}

class LoadingAddToFavouriteState extends FavouriteStates {}

class FailureAddToFavouriteState extends FavouriteStates {
  final String message;

  FailureAddToFavouriteState({required this.message});
}
