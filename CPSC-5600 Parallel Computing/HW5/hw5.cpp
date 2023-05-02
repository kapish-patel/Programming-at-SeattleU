/**
 * @file ColorKMeansMPI.cpp - implementation code for ColorKMeansMPI class
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Winter 2023"
 */
#include <iostream>
#include <fstream>
#include <vector>
#include "ColorKMeansMPI.h"
#include "mpi.h"

using namespace std;

const int K = 9;

// declaration of html helper functions
void html_cell(ofstream &f, const Color &c, const string &name);
void to_html(const ColorKMeansMPI<K>::Clusters& clusters,
             const Color *colorList, const string *colorLabels,
             const string& filename);

// main test (k-means clustering of X11 colors)
int main() {
	Color *colorList;
	string *colorLabels;

	MPI_Init(nullptr, nullptr);
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // Set up k-means
    ColorKMeansMPI<K> kMeans;

	if (rank == 0) {
    	// Set up some data using colors from X11
    	int nColors;
    	Color::x11Colors(&colorList, &colorLabels, &nColors);
    	kMeans.fit(colorList, nColors);
	} else {
		kMeans.fitWork(rank);
		MPI_Finalize();
		return 0;
	}

    // get the result
    ColorKMeansMPI<K>::Clusters clusters = kMeans.getClusters();

    // Report the result to console
    int i = 0;
    for (const auto& cluster: clusters) {
        Color centroid = cluster.centroid;
        cout << endl << endl << "cluster #" << ++i << " centered at " << centroid.hex_label()
            << ":" << endl;
        /*for (int j: cluster.elements)
            cout << colorLabels[j] << ": " << colorList[j].hex_label() << endl;*/
    }

    // Also report as a visualization in html for a browser to display
    string filename("kmean_colors_MPI.html");
    to_html(clusters, colorList, colorLabels, filename);
    delete[] colorList;
    delete[] colorLabels;
    cout << endl << "Try displaying visualization file, " << filename << ", in a web browser!" << endl;

	MPI_Finalize();
    return 0;
}

void to_html(const ColorKMeansMPI<K>::Clusters& clusters,
             const Color *colorList, const string *colorLabels,
             const string& filename) {
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
