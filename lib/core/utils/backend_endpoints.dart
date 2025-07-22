abstract class BackendEndpoints {
  static const String url = "http://localhost:8383/api/";
  static const String signIn = "auth/login";
  static const String signOut = "auth/signout";
  static const String forgetPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password";
  static const String changePassword = "auth/change-password";
  static const String uploadProfilePhoto = "auth/upload-Profile-photo";
  static const String deleteProfilePhoto = "auth/delete-Profile-photo";
  static const String getUsers = "admin/get-users";
  static const String banUser = "admin/ban-user/";
  static const String unbanUser = "admin/unban-user/";
  static const String deleteUser = "admin/delete-user/";
  static const String createUserByAdmin = "admin/create-user";

  static const String addProduct = "products/add-product";
  static const String updateProduct = "products/edit-product";
  static const String deleteProduct = "products/delete-product";
  static const String getProducts = "products/get-products";
}
