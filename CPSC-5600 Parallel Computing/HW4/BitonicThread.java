/*
 * Kapish Patel
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */

// Imports
import java.util.concurrent.ThreadLocalRandom;
import java.util.*;
import java.util.concurrent.CyclicBarrier;


/**
    * Class BitonicThread which implemments Runnable
    * holds everything including main method and all the methods for bitonic sort
    * constructor accepts data[] of double type  
*/
class BitonicThread implements Runnable
{
    /**
        *   Data members of BitonicThread 
     */
    public static final int N = 1 << 22;  // size of the array to sort array (power of two)
    public static final int TIME_ALLOWED = 10;  // Number of seconds to wait
    public static final int NUMBER_OF_THREADS = 8;    // Number of threads used to solve bitonic sort
    public static CyclicBarrier barrier;    // Barrier for coordination between threads
    double[] result = new double[N];     // result to store the array for result 


    /**
        *   Member Function of BitonicThread
        *   1 Constructor BitonicThread
        *   2 main method
        *   3 getarray 
        *   4 run
        *   5 isSorted
        *   6 swap
        *   7 Bsort
    */

    // constructor BitonicThread accepts array of Double type
    public BitonicThread(double[] data)
    {
        result = data;
    }
    
    // main method accepts arguments returns nothing 
    public static void main(String []args)
    {
        long start = System.currentTimeMillis();
        int work = 0;
        Thread[] trd = new Thread[NUMBER_OF_THREADS];   // Creating object for thread

        // Creating instance of CyclicBarrier
        BitonicThread.barrier = new CyclicBarrier(NUMBER_OF_THREADS);   

        // While loop for running program for 10 seconds
        while (System.currentTimeMillis() < start + TIME_ALLOWED * 1000) 
        {
            double[][] data = new double[1][N]; // Data to store arrays     
             
            for (int section = 0; section < data.length; section++) 
            {
                // Generate the array with getarray which randomly generates array.
                data[section] = getArray(N);

                // For loop to make and start threads
                for (int i = 0; i < NUMBER_OF_THREADS; i++)
                {
                    trd[i] = new Thread(new BitonicThread(data[section]), String.valueOf(i));    
                    trd[i].start();
                }

                // for loop to join all the threads so program runs smooth 
                for (int i = 0; i < NUMBER_OF_THREADS; i++)
                {
                    try
                    {
                        trd[i].join();
                    }
                    catch(Exception e)
                    {}
                }
            }

            // validation for the sorted arrays.
            for (int i = 0; i < data.length; i++)
            {
                if (!isSorted(data[i]))
                    System.out.println("failed");
                //else
                //    System.out.println(work+" Array Sorted");

                work++;
            }
        }
        System.out.println("sorted " + work + " arrays (each: " + N + " doubles) in "
                + TIME_ALLOWED + " seconds");    
    }

    // rum method which comes from runnable class takes no arguments
    @Override
    public void run()
    {   
        // split data according to id of thread
        int id = Integer.parseInt(Thread.currentThread().getName());
        int length_per_Thread = N/NUMBER_OF_THREADS;
        int start = id * length_per_Thread;
        int end = start + length_per_Thread;
        Bsort(start, end);
    }

    // getArray method to sends a random array for n size 
    public static double[] getArray(int n) 
    {
        double ret[] = new double[n];
        for (int i = 0; i < n; i++)
            ret[i] = ThreadLocalRandom.current().nextDouble() * 100.0;
        return ret;
    }

    // isSorted method to check  the array is sorted or not in the validation part
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
        }
        return true;
    }

    // swap method to swap values takes data to double type, int i and int j as position where to change
    private void swap(double[] data, int i, int j) 
    {
        double temp = data[i];
        data[i] = data[j];
        data[j] = temp;
    }

    // Bsort method which uses 3 for loop K,J,I
    public void Bsort(int start, int end)
    {
        // Barrier to wait for all the threads to complete the operations
        try{ barrier.await(); }
        catch(Exception e){ }

        /**
            * k is size of the pieces, starting at pairs and doubling up until we get to the whole array
            * k also determines if we want ascending or descending for each section of i's
            * corresponds to 1<<d in textbook
            * k is one bit, marching to the left
        */
        for (int k = 2; k <= result.length; k *= 2)
        { 
            // Barrier to wait for all the threads to complete the operations
            try{ barrier.await(); }
            catch(Exception e){ }

            /**
                * j is the distance between the first and second halves of the merge
                * corresponds to 1<<p in textbook
                * j is one bit, marching from k to the right  
            */
            for (int j = k / 2; j > 0; j /= 2) 
            {  
                // Barrier to wait for all the threads to complete the operations
                try{ barrier.await(); }
                catch(Exception e){ }

                // i loop which starts from the start value and ends at end value of a thread.
                for (int i = start; i < end; i++) 
                {
                    // xor: all the bits that are on in one and off in the other
                    int ixj = i^j;  
                    
                    // only compare if ixj is to the right of i
                    if (ixj > i) 
                    {
                        if ((i & k) == 0 && (result[i] > result[ixj]))
                            swap(result, i, ixj);

                        if ((i & k) != 0 && (result[i] < result[ixj]))
                            swap(result, i, ixj);  
                    }// end of if

                }// end of i loop

            }// end of j loop

        }// end of k loop

    }// end of Bsort method

}// end of BitonicThread class


/**
    * Output
        sorted 20 arrays (each: 4194304 doubles) in 10 seconds.
    
    * NOTE:
        * I amm not sure what will be the actual output but i think my output is under expected output
        * Some time the output will varies depending upon the thread because some time it sorts 32, 29 arrays so + or - 1 or 2 array.

*/