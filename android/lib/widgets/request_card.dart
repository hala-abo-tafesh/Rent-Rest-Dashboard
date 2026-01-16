import 'package:flutter/material.dart';
import 'package:admin_interface/models/users_model.dart';
import 'package:admin_interface/theme/colors.dart';
import '../page/user_details_page.dart';
import '../widgets/custom_button.dart';

class RequestCard extends StatelessWidget {
  final UsersModel user;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const RequestCard({
    super.key,
    required this.user,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;
    final textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final softFill = isDark ? Colors.white.withOpacity(.06) : Colors.black.withOpacity(.04);
    final softBorder = isDark ? Colors.white.withOpacity(.10) : Colors.black.withOpacity(.06);
    final shadow = isDark ? Colors.black.withOpacity(.30) : Colors.black.withOpacity(.06);

    const hPad = 16.0;
    const vPad = 14.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border.withOpacity(isDark ? .85 : 1)),
        boxShadow: [
          BoxShadow(
            color: shadow,
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(.92),
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                child: Row(
                  children: [
                    _Avatar(url: user.imageUrl, isDark: isDark),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  '${user.firstName} ${user.lastName}'.trim(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w900,
                                    color: textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              _StatusChip(
                                label: 'Pending',
                                bg: isDark
                                    ? AppColors.warning.withOpacity(.18)
                                    : AppColors.warning.withOpacity(.12),
                                fg: AppColors.warning,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            children: [
                              _MiniPill(
                                icon: Icons.badge_outlined,
                                text: _titleCase(user.role),
                                fill: softFill,
                                border: softBorder,
                                iconColor: textSecondary,
                                textColor: textPrimary,
                              ),
                              _MiniPill(
                                icon: Icons.phone_outlined,
                                text: user.phone,
                                fill: softFill,
                                border: softBorder,
                                iconColor: textSecondary,
                                textColor: textPrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _InfoRow(
                            icon: Icons.email_outlined,
                            text: user.email,
                            iconColor: textSecondary,
                            textColor: textSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: 'Show',
                            height: 38,
                            borderRadius: 12,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UserDetailsPage(user: user),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          _SuccessButton(
                            text: 'Accept',
                            height: 38,
                            borderRadius: 12,
                            onPressed: onAccept,
                          ),
                          const SizedBox(height: 10),
                          _DangerOutlineButton(
                            text: 'Reject',
                            height: 38,
                            borderRadius: 12,
                            onPressed: onReject,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _titleCase(String s) {
    final t = s.trim();
    if (t.isEmpty) return t;
    return t[0].toUpperCase() + t.substring(1).toLowerCase();
  }
}

class _SuccessButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;

  const _SuccessButton({
    required this.text,
    required this.onPressed,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _DangerOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;

  const _DangerOutlineButton({
    required this.text,
    required this.onPressed,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          side: BorderSide(color: AppColors.error.withOpacity(.60)),
          foregroundColor: AppColors.error.withOpacity(.95),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String url;
  final bool isDark;

  const _Avatar({required this.url, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final border = isDark ? Colors.white.withOpacity(.10) : Colors.black.withOpacity(.08);
    final placeholderBg = isDark ? Colors.white.withOpacity(.08) : Colors.black.withOpacity(.04);
    final iconColor = isDark ? Colors.white.withOpacity(.55) : Colors.black.withOpacity(.45);

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: border),
      ),
      child: ClipOval(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: placeholderBg,
            alignment: Alignment.center,
            child: Icon(Icons.person, color: iconColor),
          ),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: placeholderBg,
              alignment: Alignment.center,
              child: const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;

  const _StatusChip({
    required this.label,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: fg),
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color fill;
  final Color border;
  final Color iconColor;
  final Color textColor;

  const _MiniPill({
    required this.icon,
    required this.text,
    required this.fill,
    required this.border,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.5, color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
