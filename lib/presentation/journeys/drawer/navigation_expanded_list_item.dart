import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/entities/language_entity.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';

class NavigationExpanded extends StatelessWidget {
  final String title;
  final List<LanguageEntity> children;
  final Function onPressed;

  const NavigationExpanded({Key key,@required this.title,@required this.onPressed,@required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 2
          )
        ]
      ),
      child: ExpansionTile(
        title: Text(title, style: Theme.of(context).textTheme.subtitle1,),
        children: [
          for(int i = 0; i < children.length; i++)
            NavigationSubListItem(title: children[i].value, onPressed: (){
              BlocProvider.of<LanguageBloc>(context).add(ToggleLanguageEvent(children[i]));
            })
        ],
      ),
    );
  }
}
