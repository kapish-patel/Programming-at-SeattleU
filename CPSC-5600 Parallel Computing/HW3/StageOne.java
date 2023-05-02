/*
 * Kevin Lundeen
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */

import java.util.Arrays;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;

/**
 * First stage of a bitonic sorting network pipeline. This class takes in unordered
 * arrays and sorts them (using library sort since that will be faster for a small
 * one-thread sort).
 */
public class StageOne implements Runnable {
    private static final int timeout = 10;  // in seconds

    /**
     * Static method that just sorts the given array.
     *
     * @param data unordered array
     */
    public static void process(double[] data) {
        Arrays.sort(data);
    }

    /**
     * Set up a StageOne with a SynchronousQueue to read for input and one to
     * write for output.
     *
     * @param input  where to read the unordered input array
     * @param output where to write the sorted array
     */
    public StageOne(SynchronousQueue<double[]> input, SynchronousQueue<double[]> output, String name) {
        this.input = input;
        this.output = output;
        this.name = name;
    }
    public StageOne(SynchronousQueue<double[]> input, SynchronousQueue<double[]> output) {
        this(input, output, "");
    }

    /**
     * The Runnable part of the class. Polls the input queue and when ready, process (sort)
     * it and then write it to the output queue.
     */
    @Override
    public void run() {
        double[] array = new double[1];
        while (array != null) {
            try {
                array = input.poll(timeout * 1000, TimeUnit.MILLISECONDS);
                if (array != null) {
                    process(array);
                    output.offer(array, timeout * 1000, TimeUnit.MILLISECONDS);
                } else {
                    //System.out.println(getClass().getName() + " " + name + " got null array");
                    return;
                }
            } catch (InterruptedException e) {
                return;
            }
        }
    }

    private SynchronousQueue<double[]> input, output;
    private String name;
}

