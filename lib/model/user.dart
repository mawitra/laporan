// ignore_for_file: non_constant_identifier_names

class UserModel {
  final String clusterID;
  final String custID;
  final String siteID;
  final String officerID;
  final String officerName;
  final int pin;
  final String nik;
  final String image_picture;
  final String birthPlace;
  final String birthDate;
  final String gender;
  final String address;
  final String registerDate;
  final String activationDate;
  final String createBy;
  final int isActive;

  UserModel({
    required this.clusterID,
    required this.custID,
    required this.siteID,
    required this.officerID,
    required this.officerName,
    required this.pin,
    required this.nik,
    required this.image_picture,
    required this.birthPlace,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.registerDate,
    required this.activationDate,
    required this.isActive,
    required this.createBy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      clusterID: json['Cluster_ID'],
      custID: json['Cust_ID'],
      siteID: json['Site_ID'],
      officerID: json['Officer_ID'],
      officerName: json['Officer_Name'],
      pin: json['PIN'],
      nik: json['NIK'],
      image_picture: json['Image_Picture'] ?? '',
      birthPlace: json['Birth_Place'],
      birthDate: json['Birth_Date'],
      gender: json['Gender'],
      address: json['Address'],
      registerDate: json['Register_Date'],
      activationDate: json['Activation_Date'],
      isActive: json['Is_Active'],
      createBy: json['Create_By'],
    );
  }
}

class UserLoginModel {
  final String username;
  final int id;
  final String password;
  final int isActive;
  final int isLapor;
  final int isHadir;
  final int levelID;

  UserLoginModel({
    required this.username,
    required this.id,
    required this.password,
    required this.isActive,
    required this.isLapor,
    required this.isHadir,
    required this.levelID,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      username: json['username'],
      id: json['id'],
      password: json['password'],
      isActive: json['Is_Active'],
      isLapor: json['Is_Lapor'],
      isHadir: json['Is_Hadir'],
      levelID: json['Level_ID'],
    );
  }
}
