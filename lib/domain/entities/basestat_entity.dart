class BaseStatEntity {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final double avgPower;

  const BaseStatEntity({
    required this.attack,
    required this.avgPower,
    required this.defense,
    required this.hp,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });
}
