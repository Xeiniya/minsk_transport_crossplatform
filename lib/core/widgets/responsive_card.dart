import 'package:flutter/material.dart';

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  
  const ResponsiveCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final padding = isMobile ? const EdgeInsets.all(8) : const EdgeInsets.all(12);
    
    return Padding(
      padding: padding,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}