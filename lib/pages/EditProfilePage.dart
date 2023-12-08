import 'package:flutter/material.dart';

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController birthDayController = TextEditingController();
TextEditingController avatarController = TextEditingController();
TextEditingController phoneController = TextEditingController();

// Widget cho trang chỉnh sửa thông tin người dùng
class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            // ...Thêm các TextFormField cho các trường thông tin còn lại
            ElevatedButton(
              onPressed: () {
                // Lưu thông tin đã chỉnh sửa và cập nhật vào cơ sở dữ liệu
                _saveChanges();
                // Quay về trang cá nhân sau khi lưu
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để lưu thông tin đã chỉnh sửa
  void _saveChanges() {
    // Lấy giá trị từ các controller và cập nhật vào user
    String newFirstName = firstNameController.text;
    String newLastName = lastNameController.text;
    // Lưu các giá trị mới vào đối tượng user hoặc gửi thông tin đi đâu đó để lưu
  }
}
