class Impact {
  final int ecology;
  final int localEconomy;
  final int money;
  final int society;

  Impact({
    required this.ecology,
    required this.localEconomy,
    required this.money,
    required this.society,
  });

  factory Impact.fromJson(Map<String, dynamic> json) {
    return Impact(
      ecology: json['ecology'],
      localEconomy: json['localEconomy'],
      money: json['money'],
      society: json['society'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ecology': ecology,
    'localEconomy': localEconomy,
    'money': money,
    'society': society,
  };
}

class Impacts {
  final Impact yes;
  final Impact no;

  Impacts({required this.yes, required this.no});

  factory Impacts.fromJson(Map<String, dynamic> json) {
    return Impacts(
      yes: Impact.fromJson(json['yes']),
      no: Impact.fromJson(json['no']),
    );
  }

  Map<String, dynamic> toJson() => {
    'yes': yes.toJson(),
    'no': no.toJson(),
  };
}