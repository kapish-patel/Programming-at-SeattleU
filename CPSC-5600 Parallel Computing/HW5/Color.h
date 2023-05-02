/**
 * @file Color.h - a class to hold RGB colors, including an Euclidean distance function, and the X11 color set
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Winter 2023"
 */
#pragma once

#include <iostream>
#include <string>
#include <cmath>
#include <array>

class Color {
public:
    std::array<u_char,3> rgb;

    // ctor's and related
    Color();
    Color(std::array<u_char,3> as_3array);  // not "explicit" since we want automatic conversion from array
    Color(u_char red, u_char green, u_char blue);
    explicit Color(int hex);
    friend bool operator==(const Color &l, const Color &r);

    // component colors
    u_char red() const;
    u_char green() const;
    u_char blue() const;
    void set(u_char r, u_char g, u_char b);

    // labelling
    std::string hex_label() const;

    // distance, etc.
    double euclidDistance(const Color &other) const;
    u_char luma() const;
    bool isDark() const;

    // color set
    static void x11Colors(Color **data, std::string **labels, int *size);
};
