/**
 * @file Color.cpp - implementation of Color class methods
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Winter 2023"
 */

#include "Color.h"

#include <utility>

using namespace std;

/**
 * ctor's and related
 */
Color::Color() : Color(0, 0, 0) {}
Color::Color(const array<u_char, 3> as_3array) : rgb(as_3array) {}
Color::Color(u_char r, u_char g, u_char b) : rgb({r,g,b}) {}
Color::Color(int hex) : rgb({(u_char)(hex >> 16), (u_char)(hex >> 8 & 0xff), (u_char)(hex & 0xff)}) {}
bool operator==(const Color &l, const Color &r) {
    return l.rgb == r.rgb;
}

u_char Color::red() const {
    return rgb[0];
}

u_char Color::green() const {
    return rgb[1];
}

u_char Color::blue() const {
    return rgb[2];
}

void Color::set(u_char r, u_char g, u_char b) {
    rgb[0] = r;
    rgb[1] = g;
    rgb[2] = b;
}

std::string Color::hex_label() const {
    char buffer[7];
    snprintf(buffer, sizeof(buffer), "%.6x", red() << 16 | green() << 8 | blue());
    return {buffer};
}

double Color::euclidDistance(const Color &other) const {
    double r = (double) red() - (double) other.red();
    double g = (double) green() - (double) other.green();
    double b = (double) blue() - (double) other.blue();
    return sqrt(r * r + g * g + b * b);
}

u_char Color::luma() const {
    return (u_char )(0.2126 * red() + 0.7152 * green() + 0.0722 * blue()); // per ITU-R BT.709
}

bool Color::isDark() const {
    return luma() < 70;
}

void addX11(Color *colors, string *names, int i, int hex, string name) {
    colors[i] = Color(hex);
    names[i] = std::move(name);
}
void Color::x11Colors(Color **data, string **labels, int *size) {
    const int MAX = 200;
    auto *colors = new Color[MAX];
    auto *names = new string[MAX];
    int i = 0;
    addX11(colors, names, i++, 0xF0F8FF, "Alice Blue");
    addX11(colors, names, i++,0xFAEBD7, "Antique White");
    addX11(colors, names, i++,0x00FFFF, "Aqua");
    addX11(colors, names, i++,0x7FFFD4, "Aquamarine");
    addX11(colors, names, i++,0xF0FFFF, "Azure");
    addX11(colors, names, i++,0xF5F5DC, "Beige");
    addX11(colors, names, i++,0xFFE4C4, "Bisque");
    addX11(colors, names, i++,0x000000, "Black");
    addX11(colors, names, i++,0xFFEBCD, "Blanched Almond");
    addX11(colors, names, i++,0x0000FF, "Blue");
    addX11(colors, names, i++,0x8A2BE2, "Blue Violet");
    addX11(colors, names, i++,0xA52A2A, "Brown");
    addX11(colors, names, i++,0xDEB887, "Burlywood");
    addX11(colors, names, i++,0x5F9EA0, "Cadet Blue");
    addX11(colors, names, i++,0x7FFF00, "Chartreuse");
    addX11(colors, names, i++,0xD2691E, "Chocolate");
    addX11(colors, names, i++,0xFF7F50, "Coral");
    addX11(colors, names, i++,0x6495ED, "Cornflower Blue");
    addX11(colors, names, i++,0xFFF8DC, "Cornsilk");
    addX11(colors, names, i++,0xDC143C, "Crimson");
    addX11(colors, names, i++,0x00FFFF, "Cyan");
    addX11(colors, names, i++,0x00008B, "Dark Blue");
    addX11(colors, names, i++,0x008B8B, "Dark Cyan");
    addX11(colors, names, i++,0xB8860B, "Dark Goldenrod");
    addX11(colors, names, i++,0xA9A9A9, "Dark Gray");
    addX11(colors, names, i++,0x006400, "Dark Green");
    addX11(colors, names, i++,0xBDB76B, "Dark Khaki");
    addX11(colors, names, i++,0x8B008B, "Dark Magenta");
    addX11(colors, names, i++,0x556B2F, "Dark Olive Green");
    addX11(colors, names, i++,0xFF8C00, "Dark Orange");
    addX11(colors, names, i++,0x9932CC, "Dark Orchid");
    addX11(colors, names, i++,0x8B0000, "Dark Red");
    addX11(colors, names, i++,0xE9967A, "Dark Salmon");
    addX11(colors, names, i++,0x8FBC8F, "Dark Sea Green");
    addX11(colors, names, i++,0x483D8B, "Dark Slate Blue");
    addX11(colors, names, i++,0x2F4F4F, "Dark Slate Gray");
    addX11(colors, names, i++,0x00CED1, "Dark Turquoise");
    addX11(colors, names, i++,0x9400D3, "Dark Violet");
    addX11(colors, names, i++,0xFF1493, "Deep Pink");
    addX11(colors, names, i++,0x00BFFF, "Deep Sky Blue");
    addX11(colors, names, i++,0x696969, "Dim Gray");
    addX11(colors, names, i++,0x1E90FF, "Dodger Blue");
    addX11(colors, names, i++,0xB22222, "Firebrick");
    addX11(colors, names, i++,0xFFFAF0, "Floral White");
    addX11(colors, names, i++,0x228B22, "Forest Green");
    addX11(colors, names, i++,0xFF00FF, "Fuchsia");
    addX11(colors, names, i++,0xDCDCDC, "Gainsboro");
    addX11(colors, names, i++,0xF8F8FF, "Ghost White");
    addX11(colors, names, i++,0xFFD700, "Gold");
    addX11(colors, names, i++,0xDAA520, "Goldenrod");
    addX11(colors, names, i++,0xBEBEBE, "Gray");
    addX11(colors, names, i++,0x808080, "Web Gray");
    addX11(colors, names, i++,0x00FF00, "Green");
    addX11(colors, names, i++,0x008000, "Web Green");
    addX11(colors, names, i++,0xADFF2F, "Green Yellow");
    addX11(colors, names, i++,0xF0FFF0, "Honeydew");
    addX11(colors, names, i++,0xFF69B4, "Hot Pink");
    addX11(colors, names, i++,0xCD5C5C, "Indian Red");
    addX11(colors, names, i++,0x4B0082, "Indigo");
    addX11(colors, names, i++,0xFFFFF0, "Ivory");
    addX11(colors, names, i++,0xF0E68C, "Khaki");
    addX11(colors, names, i++,0xE6E6FA, "Lavender");
    addX11(colors, names, i++,0xFFF0F5, "Lavender Blush");
    addX11(colors, names, i++,0x7CFC00, "Lawn Green");
    addX11(colors, names, i++,0xFFFACD, "Lemon Chiffon");
    addX11(colors, names, i++,0xADD8E6, "Light Blue");
    addX11(colors, names, i++,0xF08080, "Light Coral");
    addX11(colors, names, i++,0xE0FFFF, "Light Cyan");
    addX11(colors, names, i++,0xFAFAD2, "Light Goldenrod");
    addX11(colors, names, i++,0xD3D3D3, "Light Gray");
    addX11(colors, names, i++,0x90EE90, "Light Green");
    addX11(colors, names, i++,0xFFB6C1, "Light Pink");
    addX11(colors, names, i++,0xFFA07A, "Light Salmon");
    addX11(colors, names, i++,0x20B2AA, "Light Sea Green");
    addX11(colors, names, i++,0x87CEFA, "Light Sky Blue");
    addX11(colors, names, i++,0x778899, "Light Slate Gray");
    addX11(colors, names, i++,0xB0C4DE, "Light Steel Blue");
    addX11(colors, names, i++,0xFFFFE0, "Light Yellow");
    addX11(colors, names, i++,0x00FF00, "Lime");
    addX11(colors, names, i++,0x32CD32, "Lime Green");
    addX11(colors, names, i++,0xFAF0E6, "Linen");
    addX11(colors, names, i++,0xFF00FF, "Magenta");
    addX11(colors, names, i++,0xB03060, "Maroon");
    addX11(colors, names, i++,0x800000, "Web Maroon");
    addX11(colors, names, i++,0x66CDAA, "Medium Aquamarine");
    addX11(colors, names, i++,0x0000CD, "Medium Blue");
    addX11(colors, names, i++,0xBA55D3, "Medium Orchid");
    addX11(colors, names, i++,0x9370DB, "Medium Purple");
    addX11(colors, names, i++,0x3CB371, "Medium Sea Green");
    addX11(colors, names, i++,0x7B68EE, "Medium Slate Blue");
    addX11(colors, names, i++,0x00FA9A, "Medium Spring Green");
    addX11(colors, names, i++,0x48D1CC, "Medium Turquoise");
    addX11(colors, names, i++,0xC71585, "Medium Violet Red");
    addX11(colors, names, i++,0x191970, "Midnight Blue");
    addX11(colors, names, i++,0xF5FFFA, "Mint Cream");
    addX11(colors, names, i++,0xFFE4E1, "Misty Rose");
    addX11(colors, names, i++,0xFFE4B5, "Moccasin");
    addX11(colors, names, i++,0xFFDEAD, "Navajo White");
    addX11(colors, names, i++,0x000080, "Navy Blue");
    addX11(colors, names, i++,0xFDF5E6, "Old Lace");
    addX11(colors, names, i++,0x808000, "Olive");
    addX11(colors, names, i++,0x6B8E23, "Olive Drab");
    addX11(colors, names, i++,0xFFA500, "Orange");
    addX11(colors, names, i++,0xFF4500, "Orange Red");
    addX11(colors, names, i++,0xDA70D6, "Orchid");
    addX11(colors, names, i++,0xEEE8AA, "Pale Goldenrod");
    addX11(colors, names, i++,0x98FB98, "Pale Green");
    addX11(colors, names, i++,0xAFEEEE, "Pale Turquoise");
    addX11(colors, names, i++,0xDB7093, "Pale Violet Red");
    addX11(colors, names, i++,0xFFEFD5, "Papaya Whip");
    addX11(colors, names, i++,0xFFDAB9, "Peach Puff");
    addX11(colors, names, i++,0xCD853F, "Peru");
    addX11(colors, names, i++,0xFFC0CB, "Pink");
    addX11(colors, names, i++,0xDDA0DD, "Plum");
    addX11(colors, names, i++,0xB0E0E6, "Powder Blue");
    addX11(colors, names, i++,0xA020F0, "Purple");
    addX11(colors, names, i++,0x800080, "Web Purple");
    addX11(colors, names, i++,0x663399, "Rebecca Purple");
    addX11(colors, names, i++,0xFF0000, "Red");
    addX11(colors, names, i++,0xBC8F8F, "Rosy Brown");
    addX11(colors, names, i++,0x4169E1, "Royal Blue");
    addX11(colors, names, i++,0x8B4513, "Saddle Brown");
    addX11(colors, names, i++,0xFA8072, "Salmon");
    addX11(colors, names, i++,0xF4A460, "Sandy Brown");
    addX11(colors, names, i++,0x2E8B57, "Sea Green");
    addX11(colors, names, i++,0xFFF5EE, "Seashell");
    addX11(colors, names, i++,0xA0522D, "Sienna");
    addX11(colors, names, i++,0xC0C0C0, "Silver");
    addX11(colors, names, i++,0x87CEEB, "Sky Blue");
    addX11(colors, names, i++,0x6A5ACD, "Slate Blue");
    addX11(colors, names, i++,0x708090, "Slate Gray");
    addX11(colors, names, i++,0xFFFAFA, "Snow");
    addX11(colors, names, i++,0x00FF7F, "Spring Green");
    addX11(colors, names, i++,0x4682B4, "Steel Blue");
    addX11(colors, names, i++,0xD2B48C, "Tan");
    addX11(colors, names, i++,0x008080, "Teal");
    addX11(colors, names, i++,0xD8BFD8, "Thistle");
    addX11(colors, names, i++,0xFF6347, "Tomato");
    addX11(colors, names, i++,0x40E0D0, "Turquoise");
    addX11(colors, names, i++,0xEE82EE, "Violet");
    addX11(colors, names, i++,0xF5DEB3, "Wheat");
    addX11(colors, names, i++,0xFFFFFF, "White");
    addX11(colors, names, i++,0xF5F5F5, "White Smoke");
    addX11(colors, names, i++,0xFFFF00, "Yellow");
    addX11(colors, names, i++,0x9ACD32, "Yellow Green");
    *data = colors;
    *labels = names;
    *size = i;
}

