import 'package:flutter/widgets.dart' as fl;
import 'ui.dart' as ui;
import 'hero.dart' show Hero, StudyingState;
import 'game.dart' show Game;

sealed class View {
  fl.Widget build(Game game);
}

class HeroView implements View {
  HeroView(this.hero);

  final Hero hero;

  @override
  fl.Widget build(Game game) {
    return ui.column(<fl.Widget>[
      ui.text(hero.name),
      ui.table([
        [ui.text('Level'), ui.text(hero.level.toString())],
        [ui.text('XP'), ui.text(hero.xp.toString())],
        [ui.text('HP'), ui.text(hero.hp.toString())],
        [ui.text('State'), ui.text(hero.state.toString())],
      ]),
      ui.row([
        ui.button('Study', () {
          game.updateHeroState(hero, StudyingState());
          game.updateView(const DefaultView());
        }),
        ui.button('Return', () => game.updateView(const DefaultView())),
      ]),
    ]);
  }
}

class DefaultView implements View {
  const DefaultView();

  @override
  fl.Widget build(Game game) {
    final globalStatus = <fl.Widget>[
      ui.table([
        [ui.text(game.clock.time)],
      ]),
    ];

    final heroStatus = <fl.Widget>[
      ui.text('Heroes:'),
      ui.table([
        [
          'Name',
          'Species',
          'Job',
          'Level',
          'XP',
          'HP',
          'Status',
        ].map((s) => ui.text(s)).toList(),
        ...game.heroes.map(
          (hero) => <fl.Widget>[
            ui.button(hero.name, () => game.updateView(HeroView(hero))),
            ui.text(hero.species.toString()),
            ui.text('job?'),
            ui.text(hero.level.toString()),
            ui.text(hero.xp.toString()),
            ui.text(hero.hp.toStringAsFixed(0)),
            ui.text(hero.state.toString()),
          ],
        ),
      ]),
    ];

    final loreStatus = <fl.Widget>[
      ui.text('Lore:'),
      ui.padding(
        ui.border(
          fl.Column(
            crossAxisAlignment: fl.CrossAxisAlignment.start,
            children: game.lore.lore.map((s) => ui.text(s)).toList(),
          ),
        ),
      ),
    ];

    return ui.column(<fl.Widget>[
      ...globalStatus,
      ...heroStatus,
      ...loreStatus,
    ]);
  }
}
