#include <cstdio>
#include <readline/history.h>
#include <readline/readline.h>
#include <string>
#include <vector>

void parse_command(std::string command) {
  if (command == "exit") {
    exit(42);
  } else {
    fprintf(stderr, "Unknown command: \"%s\"\n", command.data());
  }
}

std::vector<std::string> character_names = {"Foo Bar", "Yolo Dawg"};
char *completionGenerator(const char *text, int state) {
  static int list_index, len;

  char *name;

  if (!state) {
    list_index = 0;
    len = strlen(text);
  }

  int size = (int)character_names.size();
  while (list_index < size) {
    name = character_names[list_index++].data();
    if (strncmp(name, text, len) == 0) {
      return strdup(name);
    }
  }

  return NULL;
}

// current, start, end
char **completer(const char *current, int, int) {
  rl_attempted_completion_over = 1;
  // https://thoughtbot.com/blog/tab-completion-in-gnu-readline#r1
  return rl_completion_matches(current, completionGenerator);
}

int main() {
  rl_attempted_completion_function = completer;

  while (1) {
    const char *ptr = readline("> ");
    if (ptr == nullptr) {
      break;
    }
    std::string s = ptr;
    delete ptr;

    add_history(s.data());
    parse_command(std::move(s));
  }

  return 0;
}
