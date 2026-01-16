import 'package:admin_interface/cubits/users_cubit/users_cubit.dart';
import 'package:admin_interface/models/users_model.dart';
import 'package:admin_interface/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_button.dart';

class UserCard extends StatelessWidget {
  final UsersModel user;
  final VoidCallback? onShow;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.user,
    this.onShow,
    this.onDelete,
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

    final status = user.status.trim().toLowerCase();
    final statusUi = _statusUI(status, isDark);

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
                color: statusUi.fg.withOpacity(.92),
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                                child: Row(
                                  children: [
                                    Text(
                                      '${user.firstName} ${user.lastName}'.trim(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w900,
                                        color: textPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    _StatusChip(
                                      label: statusUi.label,
                                      bg: statusUi.bg,
                                      fg: statusUi.fg,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (user.isVerified) ...[
                                const SizedBox(width: 8),
                                _StatusChip(
                                  label: 'Verified',
                                  bg: isDark ? AppColors.info.withOpacity(.18) : AppColors.info.withOpacity(.12),
                                  fg: AppColors.info,
                                ),
                              ],
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
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            children: [
                              if (user.birthDate != null)
                                _MiniPill(
                                  icon: Icons.cake_outlined,
                                  text: _fmtDate(user.birthDate!),
                                  fill: softFill,
                                  border: softBorder,
                                  iconColor: textSecondary,
                                  textColor: textPrimary,
                                ),
                              if (user.createdAt != null)
                                _MiniPill(
                                  icon: Icons.calendar_month_outlined,
                                  text: 'Joined ${_fmtDate(user.createdAt!)}',
                                  fill: softFill,
                                  border: softBorder,
                                  iconColor: textSecondary,
                                  textColor: textPrimary,
                                ),
                            ],
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
                            onPressed: onShow,
                          ),
                          user.role == 'admin' ? SizedBox() : SizedBox(height: 10,),

                          user.role == 'admin' ? SizedBox() :SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: user.status == 'inactive' ? () {
                                context.read<UsersCubit>().acceptUser(userID: user.id);
                              }: (){
                                context.read<UsersCubit>().rejectUser(userID: user.id);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: user.status == 'active' ? Colors.grey : AppColors.success,
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: Text(
                                user.status == 'inactive' ? 'Enable' : 'Ban',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          user.role == 'admin' ? SizedBox() : SizedBox(height: 10,),
                          user.role == 'admin' ? SizedBox() : SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: (){
                                context.read<UsersCubit>().deleteUser(userID: user.id);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: AppColors.error,
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: Text(
                                'Delete',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
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

  static String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static String _titleCase(String s) {
    final t = s.trim();
    if (t.isEmpty) return t;
    return t[0].toUpperCase() + t.substring(1).toLowerCase();
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
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              color: fg,
            ),
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
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
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
            style: TextStyle(
              fontSize: 13.5,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusUIModel {
  final String label;
  final Color bg;
  final Color fg;

  _StatusUIModel({
    required this.label,
    required this.bg,
    required this.fg,
  });
}
