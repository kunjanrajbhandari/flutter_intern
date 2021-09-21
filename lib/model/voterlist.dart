class VoterList {
  String? name;
  int? voterId;
  String? age;
  String? sex;
  String? relation;
  int? contact;

  int? yes;
  int? no;
  int? maybe;
  int? abcParty;
  int? otherparty;

  VoterList(
      {required this.name,
      required this.voterId,
      required this.age,
      required this.sex,
      required this.relation,
      required this.contact,
      required this.yes,
      required this.no,
      required this.maybe,
      required this.abcParty,
      required this.otherparty});
}

class PartyList {
  String? name;
  String photo;

  PartyList({required this.name, required this.photo});
}
