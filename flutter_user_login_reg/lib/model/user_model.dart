class user_model {
  //attributes
  String? uid;
  String? email;
  String? f_name;
  String? l_name;
  String? acc_type;
  String? imagePath;

  user_model({
    this.uid,
    this.email,
    this.f_name,
    this.l_name,
    this.acc_type,
    this.imagePath,
  });

  //fetching data from the cloud store
  factory user_model.fromMap(map) {
    return user_model(
      uid: map['uid'],
      email: map['email'],
      f_name: map['f_name'],
      l_name: map['l_name'],
      acc_type: map['acc_type'],
      imagePath: map['imagePath'],
    );
  }

  //sending data to the cloud firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'f_name': f_name,
      'l_name': l_name,
      'acc_type': acc_type,
      'imagePath': imagePath,
    };
  }
}
