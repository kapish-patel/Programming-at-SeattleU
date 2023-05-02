/*
 * Kapish Patel
 * CPSC 5600, Seattle University
 * This is free and unencumbered software released into the public domain.
 */

 // Imports
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;
import java.util.Arrays;

/**
 * @class BitonicPipeline class per cpsc5600 hw3 specification.
 */
public class BitonicPipeline 
{
    public static final int N = 1 << 22;  // size of the final sorted array (power of two)
    public static final int TIME_ALLOWED = 10;  // seconds

    // Synchronous Queue variables 
    private static SynchronousQueue<double[]> Random_Array_Output = new SynchronousQueue<double[]>();
    private static SynchronousQueue<double[]> Stage_One_Input = new SynchronousQueue<double[]>();
    private static SynchronousQueue<double[]> Stage_One_Output = new SynchronousQueue<double[]>();
    private static SynchronousQueue<double[]> Bitonic_Stage_Input = new SynchronousQueue<double[]>();
    private static SynchronousQueue<double[]> Bitonic_Stage_Second_Input = new SynchronousQueue<double[]>();
    private static SynchronousQueue<double[]> Bitonic_Stage_Output = new SynchronousQueue<double[]>(); 

    /**
     * Main entry for HW3 assignment.
     *
     * @param args not used
     */
    public static void main(String[] args) 
    {
        long start = System.currentTimeMillis();
        int work = 0;
        double[][] data = new double[4][];
        double[] penult1;
        double[] penult2;
        double[] ult;

        // Thread Creation for Random Array generator
        RandomArrayGenerator arry_gen = new RandomArrayGenerator(N/4, Random_Array_Output);
        for(int i = 0; i < 4; i++)
        {
            Thread array_generator = new Thread(arry_gen);
            array_generator.start();
        }

        //Thread Creation for Stage One
        StageOne stg_one = new StageOne(Stage_One_Input, Stage_One_Output);
        for(int i = 0; i < 4; i++)
        {
            Thread stage_One = new Thread(stg_one);
            stage_One.start();
        }

        //Thread Creation for Bitonicstage 1 where we are creating 2 threads
        BitonicStage bitonic_stage_1 = new BitonicStage(Bitonic_Stage_Input, Bitonic_Stage_Second_Input, Bitonic_Stage_Output);
        for (int i = 0; i < 2; i++)
        {
            Thread bit_stg_1 = new Thread(bitonic_stage_1);
            bit_stg_1.start();
        }

        // Thread Creation for Main Bitonicstage where ae are creating one thread
        BitonicStage bitonic = new BitonicStage(Bitonic_Stage_Input, Bitonic_Stage_Second_Input, Bitonic_Stage_Output);
        Thread bitonic_sort = new Thread(bitonic);
        bitonic_sort.start();

        // While loop which runs for 10 seconds
        while (System.currentTimeMillis() < start + TIME_ALLOWED * 1000) // loop for running program for 10 seconds
        {
            try
            {
                for (int section = 0; section < data.length; section++) 
                {
                    // Sending Data to Random Array generator
                    data[section] = Random_Array_Output.poll(TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);

                    // Sending data to Stage One
                    Stage_One_Input.offer(data[section], TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                    
                    // receiving data from Stageone 
                    data[section] = Stage_One_Output.poll(TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                }

                // Sending and recieving data to and from Bitonic stage (thread 5-6)
                Bitonic_Stage_Input.offer(data[0], TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                Bitonic_Stage_Second_Input.offer(data[1],  TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                penult1 = Bitonic_Stage_Output.poll(TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                
                Bitonic_Stage_Input.offer(data[2], TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                Bitonic_Stage_Second_Input.offer(data[3], TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                penult2 = Bitonic_Stage_Output.poll(TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);

                // Sending and recieving data to and from Bitonic stage (thread 7)
                Bitonic_Stage_Input.offer(penult1, TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
                Bitonic_Stage_Second_Input.offer(penult2, TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);   
                ult = Bitonic_Stage_Output.poll(TIME_ALLOWED * 1000, TimeUnit.MILLISECONDS);
            }
            catch (InterruptedException e)
            {
                return;
            }
            // Validation
            if (!RandomArrayGenerator.isSorted(ult) || N != ult.length)
                System.out.println("failed");
            work++;
        }
        System.out.println("sorted " + work + " arrays (each: " + N + " doubles) in "
                + TIME_ALLOWED + " seconds");
        System.out.println("Completed:::");
    }
}

