import 'dart:developer';

import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_storage/get_storage.dart';

class GetStoreData {
  static final getStore = GetStorage();

  // Storing user data in the old format
  static void storeUserData({
    required String id,
    required String name,
    required String email,
    required String profileImage,
    required String phone,
    required String authToken,
    required bool isInvestor,
  }) {
    getStore.write('access_token', authToken);
    getStore.write('id', id);
    getStore.write('profile_image', profileImage);
    getStore.write('name', name);
    getStore.write('phone', phone);
    getStore.write('email', email);
    getStore.write('isInvestor', isInvestor);
  }
}

class GetStoreDataList {
  static final getStoreList = GetStorage();

  /// Stores a user in the list after checking for duplicates
  static Future<void> storeUserList(UserModel user) async {
    // Retrieve the existing user list
    List<dynamic> userList =
        getStoreList.read<List<dynamic>>('user_list') ?? [];

    // Convert the raw list to UserModel objects
    List<UserModel> users =
        userList.map((data) => UserModel.fromJson(data)).toList();

    // Check if the user already exists based on the 'id'
    bool userExists = users.any((existingUser) => existingUser.id == user.id);

    if (!userExists) {
      // Add the new user if not already present
      users.add(user);

      // Save the updated list back to storage
      await getStoreList.write(
          'user_list', users.map((u) => u.toJson()).toList());
    } else {
      print("User with id ${user.id} already exists!");
    }
  }

  /// Retrieves the list of users from local storage
  static List<UserModel> getUserList() {
    List<dynamic> userJsonList =
        getStoreList.read<List<dynamic>>('user_list') ?? [];
    return userJsonList.map((data) => UserModel.fromJson(data)).toList();
  }
}

class AccountManager {
  static Future<void> switchAccount(String userId) async {
    List<UserModel> users = GetStoreDataList.getUserList();

    // Use firstWhere with a proper fallback value for the 'orElse' parameter
    UserModel? selectedUser = users.firstWhere(
      (user) => user.id == userId,
    );

    if (selectedUser != null) {
      GetStoreData.storeUserData(
        id: selectedUser.id,
        name: selectedUser.name,
        email: selectedUser.email,
        profileImage: selectedUser.profileImage,
        phone: selectedUser.phone,
        authToken: selectedUser.authToken,
        isInvestor: selectedUser.isInvestor,
      );

      log("Switched to user: ${selectedUser.name}");

      Get.offAll(LandingScreen());
    } else {
      print("User not found!");
    }
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String phone;
  final String authToken;
  final bool isInvestor;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.phone,
    required this.authToken,
    required this.isInvestor,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      phone: json['phone'],
      authToken: json['authToken'],
      isInvestor: json['isInvestor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'phone': phone,
      'authToken': authToken,
      'isInvestor': isInvestor,
    };
  }
}

// class UserListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Fetch the list of users stored in GetStorage
//     List<UserModel> users = GetStoreData.getUserList();

//     return Scaffold(
//       appBar: AppBar(title: Text("Select a User")),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           UserModel user = users[index];

//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(user.profileImage), // Display user's profile picture
//             ),
//             title: Text(user.name),
//             subtitle: Text(user.email),
//             onTap: () {
//               // Switch to the selected user when tapped
//               AccountManager.switchAccount(user.id); // Pass user.id to switch account
//             },
//           );
//         },
//       ),
//     );
//   }
// }
