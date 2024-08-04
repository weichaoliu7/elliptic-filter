cmake_minimum_required(VERSION  3.19.2)
project(filter C)

set(CMAKE_C_STANDARD 11 "-static-libgcc -static-libstdc++")

add_executable(filter main.c)
