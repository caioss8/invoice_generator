import 'package:flutter/material.dart';

class ItemEntity {
  final int id;
  final TextEditingController description;
  final TextEditingController qtd;
  final TextEditingController price;
  final Function onDelete;

  const ItemEntity({
    required this.id,
    required this.description,
    required this.qtd,
    required this.onDelete,
    required this.price,
  });
}
