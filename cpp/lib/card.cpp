module;

#include <random>
#include <vector>

export module Card;

namespace RA {

namespace Rarity {

export enum t {
  shiny,
  rare,
  uncommon,
  common,
};

namespace Odds {

// shinyOdds    =  1; 2.5%
// rareOdds     =  3; 7.5%
// uncommonOdds =  9; 22.5%
// commonOdds   = 27; 67.5%
// multiplier   =  3
// total        = 40

constexpr unsigned long multiplier = 3;
constexpr unsigned long shiny = 1;
constexpr unsigned long rare = shiny * multiplier;
constexpr unsigned long uncommon = rare * multiplier;
constexpr unsigned long common = uncommon * multiplier;
constexpr unsigned long total = shiny + rare + uncommon + common;

} // namespace Odds

export t pick(std::minstd_rand &rand) {
  unsigned long i = rand() % Odds::total;
  unsigned long j = Odds::common;

  if (i < j) {
    return common;
  }
  j += Odds::uncommon;
  if (i < j) {
    return uncommon;
  }
  j += Odds::rare;
  if (i < j) {
    return rare;
  }

  return shiny;
}

export const char *toString(t _t) {
  switch (_t) {
  case shiny:
    return "shiny";
  case rare:
    return "rare";
  case uncommon:
    return "uncommon";
  case common:
    return "common";
  }
}

} // namespace Rarity

struct Event {
  Event(std::string _name, Rarity::t _rarity) : name(_name), rarity(_rarity) {}
  std::string name;
  Rarity::t rarity;

  static std::vector<Event> all;
};

std::vector<Event> Event::all = {
    {"yolo", Rarity::common},
};

} // namespace RA
