import 'package:flutter/material.dart';

class ClientEntity {
  final TextEditingController nome;
  final TextEditingController contact;
  final TextEditingController placa;
  final TextEditingController veiculo;
  final TextEditingController km;

  const ClientEntity({
    required this.nome,
    required this.contact,
    required this.placa,
    required this.veiculo,
    required this.km,
  });
}
