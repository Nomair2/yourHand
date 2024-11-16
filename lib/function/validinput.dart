import 'package:get/get.dart';

validInput(String val ,int min  ,String type , String password ){
  if (val.isEmpty){
      return "لا يمكن أن يكون فارغ ";
    
  } 
  if (type =='email'){
    if(!GetUtils.isEmail(val)){
      return "الأيميل غير صحيح ";
    }
  }
  if (type =='confirmPassword'){
    if(val != password ){
      return "يجب أن تطابق كلمة السر ";
    }
  }
  if(type == "password"){ 
  if(val.length < min ){
    return "يجب أن تكون كلمة السر أكثر من $min";
  }
  }
}