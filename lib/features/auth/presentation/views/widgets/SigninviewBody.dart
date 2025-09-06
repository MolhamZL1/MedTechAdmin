import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/auth/presentation/views/widgets/AppLogoCircled.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../../core/utils/app_images.dart';
import 'SignInContainerBody.dart';

class SigninviewBody extends StatelessWidget {
  const SigninviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(image: backgroundImage()),
      child: Center(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(image: backgroundImage()),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth:
                              MediaQuery.of(context).size.width < 900
                                  ? MediaQuery.of(context).size.width * .8
                                  : MediaQuery.of(context).size.width * .4,
                        ),
                        height: MediaQuery.of(context).size.height * .6,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 48,
                        ),
                        decoration: containerDecoration(context),
                        child: SignInContainerBody(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * .202,
              top: 70,
              child: AppLogoCircled(),
            ),
          ],
        ),
      ),
    );
  }

  DecorationImage backgroundImage() {
    return DecorationImage(
      image: AssetImage(AppImages.imagesLogin),
      fit: BoxFit.cover,

    );
  }
}
