/**
 * @file ColorKMeans.h - a subclass of KMeans to cluster Color objects
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Winter 2023"
 */
#pragma once
#include "KMeans.h"
#include "Color.h"

template <int k>
class ColorKMeans : public KMeans<k,3> {
public:
    void fit(Color *colors, int n) {
        // We know that a Color is actually just an array of three bytes so the cast is ok
        // NOTE: this will stop working correctly if the Color data layout is changed in any way
        KMeans<k,3>::fit(reinterpret_cast<std::array<u_char,3> *>(colors), n);
    }

protected:
    typedef std::array<u_char,3> Element;
    /**
     * We supply the distance method to the abstract KMeans class
     * We use the Euclidean distance between the colors interpreted as 3-d vectors in R,G,B space
     * @param a one color
     * @param b and another
     * @return distance between a and b; 0.0 <= distance <= 441.67 (sqrt(255^2 + 255^2 + 255^2))
     */
    double distance(const Element& a, const Element& b) const override {
        return Color(a).euclidDistance(Color(b));
    }
};
