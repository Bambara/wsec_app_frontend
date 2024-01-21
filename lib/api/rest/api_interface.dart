class ApiInterface {
  static const String signUpBuyer = 'users/signup';
  static const String signUpSeller = 'users/signupWithStore';
  static const String signIn = 'users/signin';
  static const String addStore = 'stores/create';
  static const String addStoreToUser = 'users/addStore';
  static const String addProductToStore = 'products/create';
  static const String getAllStores = 'users/userStores';
  static const String getAllProducts = 'products/all';
  static const String addStock = 'purchases/create';
  static const String getAllStock = 'products/productStock';

  static const String createAlbums = '/albums';
  static const String fetchAlbums = '/albums/1';
}
