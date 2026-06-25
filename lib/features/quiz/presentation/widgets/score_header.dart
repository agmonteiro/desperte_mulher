import 'package:flutter/material.dart';

import '../../../../core/utils/threat_level.dart';
import 'threat_level_badge.dart';

class ScoreHeader extends StatelessWidget {
  final int selectedAnswersCount;
  final ThreatLevelInfo threatLevel;

  const ScoreHeader({
    super.key,
    required this.selectedAnswersCount,
    required this.threatLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Respostas marcadas',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$selectedAnswersCount selecionadas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.88),
                        ),
                  ),
                ],
              ),
            ),
            ThreatLevelBadge(label: threatLevel.label),
          ],
        ),
      ),
    );
  }
}
