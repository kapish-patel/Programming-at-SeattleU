/*
 * Kapish Patel
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */

// Imports
import java.util.Arrays;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;

/**
   * @class BitonicStage - implements runnavle which help in running the run function on invocation of new thread 

    @param  input1 input array one 
    @param  input2 input array two which will we reversed
    @param  output output array where we want our return array   
 */
public class BitonicStage implements Runnable
{
    private static final int timeout = 10;  // in seconds
    private SynchronousQueue<double[]> input1, input2, output;
    private int size;

    //constructor
    public BitonicStage(SynchronousQueue<double[]> input1, SynchronousQueue<double[]> input2, SynchronousQueue<double[]> output, int size) 
    {
        this.input1 = input1;
        this.input2 = input2;
        this.output = output;
        this.size = size;
    }
    // Constructor
    public BitonicStage(SynchronousQueue<double[]> input1, SynchronousQueue<double[]> input2, SynchronousQueue<double[]> output) 
    {
        this.input1 = input1;
        this.input2 = input2;
        this.output = output;
    }

    //constructor
    public BitonicStage()
    {

    }
    // run method which will run on thread operation
    public void run() 
    {
        // fetch 2 array
        double[] first = new double[1];
        double[] second = new double[1];
        while (first != null && second != null) 
        {
            try 
            {
                first = input1.poll(timeout * 1000, TimeUnit.MILLISECONDS);
                second = input2.poll(timeout * 1000, TimeUnit.MILLISECONDS);

                double result[] = new double[first.length + second.length];

                reverse(second, second.length); // reverse second array

                System.arraycopy(first, 0, result, 0, first.length);
                System.arraycopy(second, 0, result, first.length, second.length);

                Bsort(result, result.length);   //bitonic sort of result 

                output.offer(result, timeout * 1000, TimeUnit.MILLISECONDS);    // Send Data to pipeline
            }
            catch (InterruptedException e ) 
            {
                return;
            }
        }
    }
    
    // enum type to detect up or down
    enum Direction 
    {
        UP,
        DOWN
    }

    // Process method to performsequencial version
    public double[] process(double []first, double []second)
    {
        double result[] = new double[first.length + second.length];

        // perform reverse of second array
        reverse(second, second.length);

        //copy both the array in a result variable
        System.arraycopy(first, 0, result, 0, first.length);
        System.arraycopy(second, 0, result, first.length, second.length);

        // perform bitonic sort on a result array and sort the array in ascending order
        Bsort(result, result.length);

        // return result array has to be sorted in ascending
        return result;
    }   

    // reverse any array
    static void reverse(double a[], int n)
    {
        double temp;
        for (int i = 0; i < n / 2; i++) 
        {
            temp = a[i];
            a[i] = a[n - i - 1];
            a[n - i - 1] = temp;
        }
    }

    // Bitonic Sort 
    void Bsort(double a[], int n) 
    {
        int m = 0;
        bitonic_sort(m, n, Direction.UP, a);
    }

    // bitonic_sort which will sort the array
    void bitonic_sort(int m, int k, Direction way, double a[]) 
    {
        if (k > 1) 
        {
            int half = k / 2;
            bitonic_merge(m, half, way, a);
            bitonic_sort(m, half, way, a);
            bitonic_sort(m + half, half, way, a);
        }
    }

    // bitonic merge method to perform merge of bitonic array
    void bitonic_merge(int m, int half, Direction way, double a[]) 
    {
        double temp;
        if (way == Direction.UP) 
        {
            for (int i = 0; i < half; i++)
            {
                if (a[m + i] > a[m + half + i])
                {
                    temp = a[m + i];
                    a[m + i] = a[m + half + i];
                    a[m + half + i] = temp;
                }
            }
        } 
        else
        {
            for (int i = 0; i < half; i++)
            {
                if (a[m + i] < a[m + half + i])
                {
                    temp = a[m + i];
                    a[m + i] = a[m + half + i];
                    a[m + half + i] = temp;
                }
            }
        }
    }
}