import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surfaceContainer,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 126, 66),
                  colorScheme.primary,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.check_box,
                            color: colorScheme.onPrimary,
                          ),
                          Text(
                            'go fidelidade',
                            style: TextStyle(
                              fontSize: 26,
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_circle_right,
                        color: colorScheme.onPrimary,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    'acumule selinhos e troque por reservas grátis, vale em todos os motéis e horários',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            spacing: 6,
            children: [
              ListTile(
                leading: Icon(
                  Icons.person_outline,
                ),
                title: Text('login'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                ),
                title: Text('ajuda'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                ),
                title: Text('configurações'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(
                  Icons.bug_report_outlined,
                ),
                title: Text('comunicar problema'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(
                  Icons.campaign_outlined,
                ),
                title: Text('tem um motel? faça parte'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
