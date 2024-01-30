import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/more/developer_info/w_team_info_section.dart';

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '개발자 정보'.text.make(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              height10,
              const TeamInfoSection(
                icon: Icon(Icons.apartment),
                title: 'InfinityCODE',
                contents:
                    '121, Dosijiwon-ro, Godeok-myeon, Pyeongtaek-si, Gyeonggi-do',
              ),
              const TeamInfoSection(
                icon: Icon(Icons.person),
                title: 'Team email',
                contents: 'Frontend Developer : bluetype55@gmail.com'
                    '\nBackend Developer : jamesoh9887@gmail.com',
              ),
              height20,
              Container(
                height: 400,
                decoration: BoxDecoration(
                    color: context.appColors.roundedLayoutBackgorund,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      'Meet the Minds Behind the Magic: Our App Development Team'
                          .text
                          .make(),
                      height10,
                      "At [InfinityCODE], innovation and creativity are at the heart of everything we do. Led by a group of talented App Developers and Backend Engineers, we're committed to delivering exceptional digital experiences."
                          .text
                          .make(),
                      height10,
                      'App Developer Extraordinaire: With a passion for sleek design and seamless functionality, our app developers transform ideas into digital reality. They ensure every tap, swipe, and scroll is a delightful experience.'
                          .text
                          .make(),
                      height10,
                      "Backend Wizardry: Our backend developers are the unsung heroes, working behind the scenes to ensure the app's performance is smooth, secure, and scalable. They are the architects of the robust platforms that power your daily interactions."
                          .text
                          .make(),
                      height10,
                      'Get in touch! Email us at [bluetype55@gmail.com] or [jamesoh9887@gmail.com] Discover more about our work'
                          .text
                          .make(),
                    ],
                  ).p(20),
                ),
              ).pSymmetric(h: 10)
            ],
          ),
        ),
      ),
    );
  }
}
