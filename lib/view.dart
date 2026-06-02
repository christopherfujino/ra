import 'package:flutter/widgets.dart' as fl;
import 'main.dart' show Game;
import 'ui.dart' as ui;
import 'hero.dart' show Hero;

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
      ui.button(
        'Return',
        onPressed: () => game.updateView(const DefaultView()),
      ),
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
      ui.table(
        game.heroes
            .map(
              (hero) => <fl.Widget>[
                ui.button(
                  hero.name,
                  onPressed: () => game.updateView(HeroView(hero)),
                ),
                ui.text("Level: ${hero.level}"),
                ui.text("XP: ${hero.xp}"),
                ui.text("HP: ${hero.hp}"),
                ui.text(hero.state.toString()),
              ],
            )
            .toList(),
      ),
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
