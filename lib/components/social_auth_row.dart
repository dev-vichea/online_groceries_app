import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_groceries_app/utils/constants.dart';

class SocialAuthRow extends StatelessWidget {
  final VoidCallback onMobileTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;

  const SocialAuthRow({
    super.key,
    required this.onMobileTap,
    required this.onGoogleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Mobile Number option
        Expanded(
          child: _SocialCard(
            label: 'Mobile',
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                size: 15,
                color: kPrimaryColor,
              ),
            ),
            onTap: onMobileTap,
          ),
        ),
        const SizedBox(width: 10),

        // Google option using SVG
        Expanded(
          child: _SocialCard(
            label: 'Google',
            icon: SvgPicture.asset(
              'assets/icons/google.svg',
              width: 20,
              height: 20,
            ),
            onTap: onGoogleTap,
          ),
        ),
        const SizedBox(width: 10),

        // Facebook option using SVG
        Expanded(
          child: _SocialCard(
            label: 'Facebook',
            icon: SvgPicture.asset(
              'assets/icons/facebook.svg',
              width: 20,
              height: 20,
            ),
            onTap: onFacebookTap,
          ),
        ),
      ],
    );
  }
}

class _SocialCard extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final cardBg = isDark ? Colors.grey.shade900 : Colors.white;

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: kPrimaryColor.withValues(alpha: 0.1),
        highlightColor: kPrimaryColor.withValues(alpha: 0.05),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
