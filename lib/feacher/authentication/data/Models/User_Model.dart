
import '../../../../core/common/Entities/User.dart';

class UserModel  extends User{
  UserModel({required super.id, required super.email, required super.password});
  factory UserModel.fromJson(Map<String , dynamic> map){
    return UserModel(id: map['id']?? '', email:map['email']??'', password: map['password']??'');
  }
}