import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicenotesapp/constants/constants.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String date;
  final void Function() onTap;
  final void Function()? onLongPress;

  const NoteTile({
    Key? key,
    required this.title,
    required this.date,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            lightShadow,
            lightPrimary,
            darkPrimary,
            darkShadow
          ],
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(date, style: GoogleFonts.jetBrainsMono(fontSize: 12)),
        tileColor: Colors.transparent, // Set to transparent
        textColor: theme.onSecondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}



