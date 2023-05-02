/*
 * Kevin Lundeen
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */

import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;

/**
 * A thread-runnable generator of an array of doubles suitable for hooking up to a pipeline
 * sorter. The array is provided to the pipeline via a SynchronousQueue provided for output.
 * A method to use this class without its own thread, getArray, is provided, too.
 * For convenience, also includes a static sort-checker.
 */
public class RandomArrayGenerator implements Runnable {
    private static final int timeout = 10;  // in seconds

    /**
     * Construct a random array generator that will write to the given output.
     *
     * @param n      how many elements in the output
     * @param output where to write the produced random array
     */
    public RandomArrayGenerator(int n, SynchronousQueue<double[]> output) {
        this.n = n;
        this.output = output;
    }

    /**
     * Does the getArray work inside of a thread and writes it to the output.
     */
    @Override
    public void run() {
        while (true)
            try {
                output.offer(getArray(n), timeout * 1000, TimeUnit.MILLISECONDS);
            } catch (InterruptedException e) {
                return;
            }
    }

    /**
     * The actual work of filling up the array with random numbers.
     *
     * @param n desired size
     * @return the random-filled array of size n
     */
    public static double[] getArray(int n) {
        double ret[] = new double[n];
        for (int i = 0; i < n; i++)
            ret[i] = ThreadLocalRandom.current().nextDouble() * 100.0;
        return ret;
    }

    /**
     * Quick check if the given array is actually sorted (ascending).
     *
     * @param a possibly sorted array
     * @return true if the given array, a, is sorted ascending
     */
    public static boolean isSorted(double[] a) {
        if (a == null)
            return false;
        double last = a[0];
        for (int i = 1; i < a.length; i++) {
            if (a[i] < last) {
                System.out.println(last + ":" + a[i]);
                return false;
            }
            last = a[i];
            //System.out.print(a[i] + " ");
        }
        //System.out.println("ok");
        return true;
    }

    private SynchronousQueue<double[]> output;
    private int n;
}

