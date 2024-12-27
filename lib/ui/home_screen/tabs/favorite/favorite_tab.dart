import 'package:event_planning/ui/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';
import '../home/event_item_widget.dart';

class FavoriteTap extends StatelessWidget {
  const FavoriteTap({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomTextField(hintText: AppLocalizations.of(context)!.search_for_event,
            hintStyle: AppStyles.bold14Primary,
            style: themeProvider.appTheme == ThemeMode.light ?
              AppStyles.medium16Black : AppStyles.medium16White,
            prefixIcon: Image.asset('assets/images/iconSearch.png'),
            borderColor: AppColors.primaryLight,),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return EventItemWidget();
                  },
                  itemCount: 20,
                )
            )
          ],
        ),
      ),
    );
  }
}
