//
// Created by Maxwell on 2022/4/26.
//

#include <iostream>
#include <string>
#include <thread>
#include <unordered_map>
#include <filesystem>

#include "engine.h"

// https://gcc.gnu.org/onlinedocs/cpp/Stringizing.html
#define PILOTBOBI_XSTR(s) PILOTBOBI_STR(s)
#define PILOTBOBI_STR(s) #s

int main(int argc, char** argv)
{
    std::filesystem::path pilotbobi_root_folder = std::filesystem::path(PILOTBOBI_XSTR(PILOTBOBI_ROOT_DIR));


    return 0;
}