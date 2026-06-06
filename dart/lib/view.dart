import 'package:flutter/widgets.dart' as fl;
import 'ui.dart' as ui;
import 'hero.dart' show Hero, StudyingState;
import 'game.dart' show Game;
import 'progression.dart' show Progression;

sealed class View {
  fl.Widget build(Game game);
}

class HeroView implements View {
  HeroView(this.hero);

  final Hero hero;

  @override
  fl.Widget build(Game game) {
    final level = hero.level.floor();
    final xpRemaining = Progression.forLevels.ofLevel(level) - hero.xp;
    return ui.column(<fl.Widget>[
      ui.text(hero.name),
      ui.table([
        [ui.text('Level'), ui.text(level)],
        [ui.text('XP'), ui.text('${hero.xp} of ${hero.xp + xpRemaining}')],
        [ui.text('HP'), ui.text(hero.hp.toString())],
        [ui.text('State'), ui.text(hero.state.toString())],
      ]),
      ui.row([
        ui.button('Study', () {
          game.updateHeroState(hero, StudyingState());
          game.view = const DefaultView();
          game.update();
        }),
        ui.button('Return', () {
          game.view = const DefaultView();
          game.update();
        }),
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
          'Level',
          'XP',
          'HP',
          'Action',
          'Status',
        ].map((s) => ui.text(s)).toList(),
        ...game.heroes.map((hero) {
          final level = hero.level.floor();
          final xpRemaining = Progression.forLevels.ofLevel(level) - hero.xp;
          return <fl.Widget>[
            ui.button(hero.name, () {
              game.view = HeroView(hero);
              game.update();
            }),
            ui.text(hero.species),
            ui.text(level),
            ui.text('${hero.xp.floor()} (-${xpRemaining.floor()})'),
            ui.text(hero.hp.floor()),
            ui.button('Study', () {
              if (hero.setXp(hero.xp + 1)) {
                final level = hero.level.floor();
                game.lore.add(
                  '${hero.name} levelled up: ${level - 1} => $level',
                );
              }
              game.update();
            }),
            ui.text(hero.state),
          ];
        }),
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
