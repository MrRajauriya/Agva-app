// ignore_for_file: prefer_const_constructors

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Colors.transparent,
      appBar: AppBar(
                  backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 24,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Accordion(
          headerBackgroundColor: Color.fromARGB(255, 54, 54, 54),
          headerBackgroundColorOpened: Color.fromARGB(255, 181, 0, 100),
          contentBorderColor: Color.fromARGB(255, 181, 0, 100),
          contentBackgroundColor: Color.fromARGB(255, 54, 54, 54),
          contentBorderWidth: 3,
          contentHorizontalPadding: 20,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              contentVerticalPadding: 20,
              // leftIcon:
              //     const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text(
                'FAQ 1',
              ),
              content: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: contentStyle,
              ),
            ),
            AccordionSection(
              isOpen: false,
              contentVerticalPadding: 20,
              // leftIcon:
              //     const Icon(Icons.text_fields_rounded, color: Colors.white),
              header: const Text(
                'FAQ 2',
              ),
              content: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: contentStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
