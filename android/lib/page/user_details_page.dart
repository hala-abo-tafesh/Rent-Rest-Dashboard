import 'package:flutter/material.dart';
import 'package:admin_interface/models/users_model.dart';
import 'package:admin_interface/theme/colors.dart';

class UserDetailsPage extends StatelessWidget {
  final UsersModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;
    final textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final softFill = isDark ? Colors.white.withOpacity(.06) : Colors.black.withOpacity(.04);
    final softBorder = isDark ? Colors.white.withOpacity(.10) : Colors.black.withOpacity(.06);
    final shadow = isDark ? Colors.black.withOpacity(.30) : Colors.black.withOpacity(.06);

    final status = user.status.trim().toLowerCase();
    final statusUi = _statusUI(status, isDark);

    final avatarUrl = (user.imageUrl).trim();
    final idUrl = (user.idImageUrl ?? '').trim();

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: surface,
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _Avatar(url: avatarUrl, isDark: isDark),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${user.firstName} ${user.lastName}'.trim(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          _StatusChip(
                            label: statusUi.label,
                            bg: statusUi.bg,
                            fg: statusUi.fg,
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
                          if (user.isVerified)
                            _MiniPill(
                              icon: Icons.verified_outlined,
                              text: 'Email verified',
                              fill: isDark ? AppColors.info.withOpacity(.18) : AppColors.info.withOpacity(.12),
                              border: AppColors.info.withOpacity(.22),
                              iconColor: AppColors.info,
                              textColor: textPrimary,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: surface,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Information',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoTile(
                  title: 'Phone',
                  value: user.phone,
                  icon: Icons.phone_outlined,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  softFill: softFill,
                  softBorder: softBorder,
                ),
                const SizedBox(height: 10),
                _InfoTile(
                  title: 'Email',
                  value: user.email,
                  icon: Icons.email_outlined,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  softFill: softFill,
                  softBorder: softBorder,
                ),
                const SizedBox(height: 10),
                _InfoTile(
                  title: 'Date of birth',
                  value: user.birthDate != null ? _fmtDate(user.birthDate!) : '--',
                  icon: Icons.cake_outlined,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  softFill: softFill,
                  softBorder: softBorder,
                ),
                const SizedBox(height: 10),
                _InfoTile(
                  title: 'Created at',
                  value: user.createdAt != null ? _fmtDateTime(user.createdAt!) : '--',
                  icon: Icons.calendar_month_outlined,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  softFill: softFill,
                  softBorder: softBorder,
                ),
                const SizedBox(height: 10),
                _InfoTile(
                  title: 'Updated at',
                  value: user.updatedAt != null ? _fmtDateTime(user.updatedAt!) : '--',
                  icon: Icons.update_outlined,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  softFill: softFill,
                  softBorder: softBorder,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: surface,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Images',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ImageCard(
                        title: 'Personal image',
                        url: avatarUrl,
                        surface: surface,
                        border: border,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        isDark: isDark,
                        onTap: avatarUrl.isEmpty
                            ? null
                            : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullImagePage(imageUrl: avatarUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ImageCard(
                        title: 'ID image',
                        url: idUrl,
                        surface: surface,
                        border: border,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        isDark: isDark,
                        onTap: idUrl.isEmpty
                            ? null
                            : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullImagePage(imageUrl: idUrl),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static _StatusUIModel _statusUI(String status, bool isDark) {
    switch (status) {
      case 'active':
        return _StatusUIModel(
          label: 'Active',
          fg: AppColors.success,
          bg: isDark ? AppColors.success.withOpacity(.18) : AppColors.success.withOpacity(.12),
        );
      case 'inactive':
        return _StatusUIModel(
          label: 'Inactive',
          fg: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          bg: isDark ? Colors.white.withOpacity(.10) : Colors.black.withOpacity(.06),
        );
      case 'pending':
      default:
        return _StatusUIModel(
          label: 'Pending',
          fg: AppColors.warning,
          bg: isDark ? AppColors.warning.withOpacity(.18) : AppColors.warning.withOpacity(.12),
        );
    }
  }

  static String _titleCase(String s) {
    final t = s.trim();
    if (t.isEmpty) return t;
    return t[0].toUpperCase() + t.substring(1).toLowerCase();
  }

  static String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static String _fmtDateTime(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$y-$m-$day  $hh:$mm';
  }
}

class FullImagePage extends StatelessWidget {
  final String imageUrl;

  const FullImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image_outlined, size: 48),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            },
          ),
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
      width: 64,
      height: 64,
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

  const _StatusChip({required this.label, required this.bg, required this.fg});

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

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color textPrimary;
  final Color textSecondary;
  final Color softFill;
  final Color softBorder;

  const _InfoTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.textPrimary,
    required this.textSecondary,
    required this.softFill,
    required this.softBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: softFill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: softBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: softFill,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: softBorder),
            ),
            child: Icon(icon, size: 18, color: textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: textSecondary)),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '--' : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final String title;
  final String url;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;
  final VoidCallback? onTap;

  const _ImageCard({
    required this.title,
    required this.url,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final placeholderBg = isDark ? Colors.white.withOpacity(.06) : Colors.black.withOpacity(.04);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border.withOpacity(isDark ? .85 : 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: textPrimary)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: url.isEmpty
                    ? Container(
                  color: placeholderBg,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_not_supported_outlined, color: textSecondary),
                )
                    : Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: placeholderBg,
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image_outlined, color: textSecondary),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusUIModel {
  final String label;
  final Color bg;
  final Color fg;

  _StatusUIModel({required this.label, required this.bg, required this.fg});
}
