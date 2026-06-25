import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const AnswerTile({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color(0xFFD7BDE2)
        : Colors.white.withOpacity(0.16);

    final bgColor = selected
        ? const Color(0xFF7D3C98)
        : const Color(0xFF6C3483);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: Colors.white.withOpacity(0.92),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
