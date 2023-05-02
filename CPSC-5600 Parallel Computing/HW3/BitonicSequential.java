/*
 * Kevin Lundeen
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */


/**
 * @class BitonicSequential class per cpsc5600 hw3 specification.
 * @versioon 24-Jan-2020
 */
public class BitonicSequential {
    public static final int N = 1 << 22;  // size of the final sorted array (power of two)
    public static final int TIME_ALLOWED = 10;  // seconds

    /**
     * Main entry for HW3 assignment.
     *
     * @param args not used
     */
    public static void main(String[] args) {
        long start = System.currentTimeMillis();
        int work = 0;
        while (System.currentTimeMillis() < start + TIME_ALLOWED * 1000) // loop for running program for 20 seconds
        {
            double[][] data = new double[4][];
            for (int section = 0; section < data.length; section++) 
            {
                data[section] = RandomArrayGenerator.getArray(N/4);
                StageOne.process(data[section]);  // Just sorts it
            }
            // Note that BitonicStage assumes both its input arrays are sorted
            // increasing. It then inverts its second input to form a true bitonic
            // sequence from the concatenation of the first input with the inverted
            // second input.
            BitonicStage bitonic = new BitonicStage();
            double[] penult1 = bitonic.process(data[0], data[1]);
            double[] penult2 = bitonic.process(data[2], data[3]); 
            double[] ult = bitonic.process(penult1, penult2);
            if (!RandomArrayGenerator.isSorted(ult) || N != ult.length)
                System.out.println("failed");
            work++;
        }
        System.out.println("sorted " + work + " arrays (each: " + N + " doubles) in "
                + TIME_ALLOWED + " seconds");
    }
}

