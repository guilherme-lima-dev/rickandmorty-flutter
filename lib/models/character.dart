class Character {
  String? _name;
  String? _species;
  String? _status;
  String? _gender;
  String? _image;

  Character(
      {String? name,
        String? species,
        String? status,
        String? gender,
        String? image}) {
    if (name != null) {
      this._name = name;
    }
    if (species != null) {
      this._species = species;
    }
    if (status != null) {
      this._status = status;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (image != null) {
      this._image = image;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get species => _species;
  set species(String? species) => _species = species;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get image => _image;
  set image(String? image) => _image = image;

  Character.fromJson(Map<dynamic, dynamic> json) {
    _name = json['name'];
    _species = json['species'];
    _status = json['status'];
    _gender = json['gender'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['species'] = this._species;
    data['status'] = this._status;
    data['gender'] = this._gender;
    data['image'] = this._image;
    return data;
  }
}