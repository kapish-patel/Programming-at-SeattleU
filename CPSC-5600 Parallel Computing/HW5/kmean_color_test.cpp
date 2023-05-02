/**
 * @file ColorKMeans.cpp - implementation code for ColorKMeans class
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Winter 2023"
 */
#include <iostream>
#include <fstream>
#include <vector>
#include "ColorKMeans.h"

using namespace std;

// How many k in "k-means"?
const int K = 9;

// declaration of html helper functions
void html_cell(ofstream &f, const Color &c, const string &name);

void to_html(const ColorKMeans<K>::Clusters &clusters,
             const Color *colorList, const string *colorLabels,
             const string &filename);

// main test (k-means clustering of X11 colors)
int main() {
    // Set up k-means
    ColorKMeans<K> kMeans;

    // Set up some data using colors from X11
    Color *colorList;
    string *colorLabels;
    int nColors;
    Color::x11Colors(&colorList, &colorLabels, &nColors);
    /*
    cout << "Using colors:" << endl;
    for (int i = 0; i < nColors; i++)
        cout << colorLabels[i] << ": #" << colorList[i].hex_label() << endl;
    */
    kMeans.fit(colorList, nColors);

    // get the result
    ColorKMeans<K>::Clusters clusters = kMeans.getClusters();

    // Report the result to console
    int i = 0;
    for (const auto& cluster: clusters) {
        Color centroid = cluster.centroid;
        cout << endl << endl << "cluster #" << ++i << " centered at " << centroid.hex_label()
             << ":" << endl;
        for (int j: cluster.elements)
            cout << colorLabels[j] << ": " << colorList[j].hex_label() << endl;
    }

    // Also report as a visualization in html for a browser to display
    string filename("kmean_colors.html");
    to_html(clusters, colorList, colorLabels, filename);
    delete[] colorList;
    delete[] colorLabels;
    cout << endl << "Try displaying visualization file, " << filename << ", in a web browser!" << endl;

    return 0;
}

void to_html(const ColorKMeans<K>::Clusters &clusters,
             const Color *colorList, const string *colorLabels,
             const string &filename) {
    ofstream f(filename);
    f << "<table><tbody><tr>" << endl;
    for (const auto& cluster: clusters) {
        f << "  <td><table><tbody>" << endl;
        html_cell(f, cluster.centroid, "CENTERED AT");
        for (int i: cluster.elements)
            html_cell(f, colorList[i], colorLabels[i]);
        f << "</tbody></table></td>" << endl;
    }
    f << "</tr></tbody></table>" << endl;
}

void html_cell(ofstream &f, const Color &c, const string &name) {
    string hex = c.hex_label();
    f << "    <tr style=\"background:#" << hex;
    if (c.isDark())
        f << ";color:#ffffff";
    f << "\">" << endl;
    f << "      <td>" << name << "</td><td>0x" << hex << "</td>" << endl;
    f << "    </tr>" << endl;

}
