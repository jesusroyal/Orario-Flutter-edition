import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/settings/settings_bloc.dart';
import 'package:orario/domain/bloc/settings/settings_event.dart';
import 'package:orario/domain/bloc/settings/settings_state.dart';
import 'package:orario/presentation/home/admin/admin_page.dart';
import 'package:orario/presentation/home/settings/settings_tiles/about_widget.dart';
import 'package:orario/presentation/home/settings/settings_tiles/admin_widget.dart';
import 'package:orario/presentation/home/settings/settings_tiles/reset_widget.dart';
import 'package:orario/presentation/welcome/welcome_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Widget> tileList = [AboutSettingsTile()];

  SettingsBloc bloc;

  @override
  void initState() {
    bloc = SettingsBloc();
    tileList.add(AdminTile(onSubmit: (token) {
      bloc.add(AdminPageOpen(token: token));
    }));
    tileList.add(ResetSettingsTile(
      onTap: () {
        bloc.add(SettingsReset());
      },
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<SettingsBloc, SettingsState>(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Настройки'),
          ),
          body: ListView.builder(
              itemCount: tileList.length,
              itemBuilder: (context, index) {
                return tileList[index];
              }),
        ),
        listener: (context, state) {
          if (state is ResetSettingsState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomePage()));
          }
          if (state is SettingsLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Zagruzka'),
                  );
                });
          }
          if (state is TokenError) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Owibka'),
                  );
                });
          }
          if (state is OpenAdminPanel) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPage()));
          }
        },
      ),
    );
  }
}
