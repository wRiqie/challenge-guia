import 'dart:async';

import 'package:challenge_guia/app/data/models/args/suite_items_args.dart';
import 'package:challenge_guia/app/data/models/suite_model.dart';
import 'package:flutter/material.dart';

class SuiteItemsScreen extends StatefulWidget {
  const SuiteItemsScreen({super.key});

  @override
  State<SuiteItemsScreen> createState() => _SuiteItemsScreenState();
}

class _SuiteItemsScreenState extends State<SuiteItemsScreen> {
  SuiteModel? _suite;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(
      () {
        var args = ModalRoute.of(context)!.settings.arguments as SuiteItemsArgs;
        setState(() {
          _suite = args.suite;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.expand_more,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _suite?.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            _buildTextDivider('principais itens'),
            SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 18,
              direction: Axis.horizontal,
              children: (_suite?.categoryItems ?? [])
                  .map((e) => Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            e.iconUrl,
                            width: 40,
                          ),
                          Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 30,
            ),
            _buildTextDivider('tem também'),
            SizedBox(
              height: 30,
            ),
            Text(
              (_suite?.items ?? []).map((e) => e.name).join(', '),
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextDivider(String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black38)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider(color: Colors.black38)),
      ],
    );
  }
}
