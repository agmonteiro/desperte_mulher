import 'package:flutter/material.dart';

class ThreatLevelInfo {
  final String label;
  final String message;
  final Color color;

  const ThreatLevelInfo({
    required this.label,
    required this.message,
    required this.color,
  });
}

ThreatLevelInfo threatLevelFromPoints(int points) {
  if (points <= 9) {
    return const ThreatLevelInfo(
      label: 'Sem ameaça aparente',
      message: 'Não há sinais fortes no momento. Ainda assim, observe a evolução.',
      color: Colors.green,
    );
  }

  if (points <= 20) {
    return const ThreatLevelInfo(
      label: 'Pouca Ameaça',
      message: 'Há sinais iniciais de risco. Atenção e monitoramento são indicados.',
      color: Colors.lightGreen,
    );
  }

  if (points <= 35) {
    return const ThreatLevelInfo(
      label: 'Atenção',
      message: 'O padrão de risco já merece intervenção e suporte mais próximo.',
      color: Colors.orange,
    );
  }

  if (points <= 50) {
    return const ThreatLevelInfo(
      label: 'Alta Ameaça',
      message: 'O cenário indica risco elevado e necessidade de resposta imediata.',
      color: Colors.deepOrange,
    );
  }

  return const ThreatLevelInfo(
    label: 'Ameaça Crítica',
    message: 'Há indícios fortes de perigo severo. Priorize proteção e apoio urgente.',
    color: Colors.red,
  );
}
