import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/auth/presentation/views/widgets/AppLogoCircled.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../../core/utils/app_images.dart';
import 'SignInContainerBody.dart';

class SigninviewBodyMobile extends StatelessWidget {
  const SigninviewBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(image: backgroundImage()),
      child: Center(
        child: Stack(
          children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                    decoration: containerDecoration(context),
                    child: SignInContainerBody(),
                  ),
                ),
              ),
            ),
            Positioned(right: 1, left: 1, top: 70, child: AppLogoCircled()),
          ],
        ),
      ),
    );
  }

  DecorationImage backgroundImage() {
    return DecorationImage(
      image: AssetImage(AppImages.imagesLogin),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop,
      ),
    );
  }
}
