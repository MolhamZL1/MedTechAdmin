abstract class BackendEndpoints {
  static const String url = "http://localhost:8383/";
  static const String signIn = "api/auth/login";
  static const String signOut = "api/auth/signout";
  static const String forgetPassword = "api/auth/forgot-password";
  static const String resetPassword = "api/auth/reset-password";
  static const String changePassword = "api/auth/change-password";
  static const String uploadProfilePhoto = "api/auth/upload-Profile-photo";
  static const String deleteProfilePhoto = "api/auth/delete-Profile-photo";
  static const String getUsers = "api/admin/get-users";
  static const String banUser = "api/admin/ban-user/";
  static const String unbanUser = "api/admin/unban-user/";
  static const String deleteUser = "api/admin/delete-user/";
  static const String createUserByAdmin = "api/admin/create-user";

  static const String addProduct = "api/products/add-product";
  static const String updateProduct = "api/products/edit-product/";
  static const String deleteProduct = "api/products/delete-product/";
  static const String getProducts = "api/products/get-products";
  static const String getOrders="api/orders/get-orders";
  static const String getAiMessages = "api/ai-chat/messages";
  static const String sendAiMessage = "api/ai-chat/message";

}
