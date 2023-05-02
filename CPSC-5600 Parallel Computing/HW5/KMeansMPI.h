/**
 * @file KMeansMPI.h - implementation of k-means clustering algorithm
 * @author Kapish Patel
 * @see "Seattle University, CPSC5600, Winter 2023"
 */
#pragma once  // only process the first time it is included; ignore otherwise
#include <vector>
#include <random>
#include <algorithm>
#include <iostream>
#include <set>
#include <array>
#include "mpi.h"

// ROOT Process = 0
#define ROOT 0

template <int k, int d>

//KMeansMPI class implement the parallization of k-means clustering
class KMeansMPI {

/*
    PUBLIC SECTION:-
    *Define anc create Element Type
    *Declare a Cluster class Defined later
    *Define and create Cluster type
*/
public:
    typedef std::array<u_char,d> Element;
    class Cluster;
    typedef std::array<Cluster,k> Clusters;
    const int MAX_FIT_STEPS = 300;

/*
    PROTECTED SECTION:-
    *Create a elements of Element type
    *Declare a object of Clusters
    *Declare a vector named dist
*/
protected:
    const Element *elements = nullptr;       // set of elements to classify into k categories (supplied to latest call to fit())
    int n = 0;                               // number of elements in this->elements
    Clusters clusters;                       // k clusters resulting from latest call to fit()
    std::vector<std::array<double,k>> dist;  // dist[i][j] is the distance from elements[i] to clusters[j].centroid

/*
    PUBLIC SECTION:-
    * Create debugging Verbose
    * get Clusters () to get clusters
    * fit() called by root process 
    * fitwork() called by all the other processes
    * Define Cluster class which store the data of centroids and elements
*/
public:
    // debugging verbose
    const bool VERBOSE = true;  // set to true for debugging output
    #define V(stuff) if(VERBOSE) {using namespace std; stuff}

    /**
     * Expose the clusters to the client readonly.
     * @return clusters from latest call to fit()
     */
    virtual const Clusters& getClusters() 
    {
        return clusters;
    }

    //fit()function called from hw5.cpp by ROOT process only.
    virtual void fit(const Element *data, int data_n)
    {
        elements = data;
        n = data_n;
        fitWork(ROOT);
    }

    /*
        * fitWork() function called from hw5.cpp by all the other processes
        * fitwork() implement core logic of the k-means in parallel version
        * Making and Scatter partition to all the processes
        * update cluster and distances for all the processes
        * merge the clusters and broadcast the clusters 
    */
    virtual void fitWork(int rank)
    {
        //Broadcast the value of n to each process
        MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
        
        // Variables for calculating size of partition
        int size;   // number of processors
        MPI_Comm_size(MPI_COMM_WORLD, &size);   // get number of processes in size variable
        int partition_size = n / size;         // Define the size of each partition

        //Variables for calculating the nunmber of elements to send to each process
        V(cout<<"Rank : "<<rank<<"Partition Size = "<<partition_size<<"Value of n is :"<<n<<endl;)
        int *scount  = new int[size];   // array[number of process] which contains how much elements are being send to each process
        int *disp = new int[size];     //displacement or starting index
        
        //Partition to store the elements which are scattered from scatterv()
        int recvsize = n - (size - 1) * partition_size; //size of recvbuff
        Element *partition = new Element[recvsize];     //recvbuff

        // For loop for calculating displacement and sendcounts
        for (int i = 0; i < size ; i++)
        {
            disp[i] = i * partition_size;
            scount[i] = partition_size;
        }

        // this fix the size of last process as that may recieve a little big array if not divided equally
        scount[size-1] = n - (size-1) * partition_size; 

        //Scatterv() function sends data into different processes. 
        MPI_Scatterv(elements, scount, disp, MPI_UNSIGNED_CHAR, //Send Parameters
                    partition, recvsize, MPI_UNSIGNED_CHAR,     //recv Parameters
                    ROOT, MPI_COMM_WORLD);                      //root and communication

        V(cout<< rank <<"- Scattering Elements:..."<<endl;)

        // resize the distance vector according to partition 
        dist.resize(n); 

        // perform some clustering steps on the root process
        Clusters prior;
        if (rank == ROOT)
        {
            reseedClusters();
        }

        //placing clusters at random place at first and later adjusted with update cluster function
        prior = clusters;
        prior[0].centroid[0]++;

        //Generation start and end when it reaches maxsteps set to 300
        int generation = 0; 
        while(generation++ < MAX_FIT_STEPS && prior != clusters)
        {
            V(cout<<rank<<"--> Working on Generation: "<< generation << endl;)
            updateDistances(partition, recvsize, rank); //Update the distance from each point to cluster
            prior = clusters;
            updateClusters(recvsize, partition, rank);  //Update the cluster position according to average of distance
            mergeClusters(rank);    //Merge the clustes together to get only one output
            bcastCentroids(rank);   //broadcast the clusters to all the process so that they update the clusters 
        }

        //Free Up Memory
        delete[] partition; 
        partition = nullptr;
    }

    /**
     * The algorithm constructs k clusters and attempts to populate them with like neighbors.
     * This inner class, Cluster, holds each cluster's centroid (mean) and the index of the objects
     * belonging to this cluster.
     */
    struct Cluster {
        Element centroid;  // the current center (mean) of the elements in the cluster
        std::vector<int> elements;

        // equality is just the centroids, regarless of elements
        friend bool operator==(const Cluster& left, const Cluster& right) {
            return left.centroid == right.centroid;  // equality means the same centroid, regardless of elements
        }
    };

protected:
    //Mergecluster() function merge the clusters together to get one output
    virtual void mergeClusters(int rank)
    {
        
        int size;							  // number of processor
		MPI_Comm_size(MPI_COMM_WORLD, &size); //  get no of process

        //Variables for send centroid
		u_char *centroid_sendbuff = new u_char[d * k];
		u_char *centroid_recv_buff;
        
        //Variables for recv centroids
		int *recvcount_centroid;
		int *recvdisp_centroid;

		int sendcount_centroid = d * k;

        //Variables for sending and recv elements
		int *sendbuff_elements = new int[k * n]; // send buffer for elements
		int *disp_elements;						 // displacement for starting index of each processor
		int *recvcount_elements;				 //  size of data  each processor is reponsible
		int *recvbuff_elements;

        // For loop for setting send centroid
		int jd = 0;
		for (int i = 0; i < k; i++)
		{
			for (int j = 0; j < d; j++)
			{
				centroid_sendbuff[jd++] = clusters[i].centroid[j];
			}
		}

        //For loop for adjusting elements in cluster
		for (int i = 0; i < k; i++)
		{
			int size_cluster = clusters[i].elements.size();
			if (size_cluster != n)
			{
				// add dummy value to make size equal to n
				size_cluster = n - size_cluster;
			}
			if (size_cluster > 0)
			{
				for (int j = 0; j < size_cluster; j++)
				{
					clusters[i].elements.push_back(-1);
				}
			}
		}

        //for loop for setting send elements 
		int jq = 0;
		for (int i = 0; i < k; i++)
		{
			//int size_cluster = clusters[i].elements.size();
			// V(cout << "size of cluster elements" << size_cluster << "n size" << n << endl;)

			for (int l = 0; l < n; l++)
			{

				sendbuff_elements[jq++] = clusters[i].elements[l];
			}
		}
		//	V(cout << rank << "jq value" << jq << endl;)

		//ROOT Process only 
		if (rank == ROOT)
		{
            //variable setup
			centroid_recv_buff = new u_char[d * k * size];
			recvcount_centroid = new int[size];
			recvdisp_centroid = new int[size];

			disp_elements = new int[size];
			recvcount_elements = new int[size];
			recvbuff_elements = new int[n * size * k];

            //Setting values of scounts and recvcounts
			for (int i = 0; i < size; i++)
			{
				recvcount_centroid[i] = k * d;
				recvdisp_centroid[i] = i * (k * d);
				recvcount_elements[i] = n * k;
				disp_elements[i] = i * (n * k);
			}
		}

        //Gatherv for centroid
		MPI_Gatherv(centroid_sendbuff, sendcount_centroid, MPI_UNSIGNED_CHAR,
					centroid_recv_buff, recvcount_centroid, recvdisp_centroid,
					MPI_UNSIGNED_CHAR, ROOT, MPI_COMM_WORLD);

        //Gatherv for elements
		MPI_Gatherv(sendbuff_elements, n * k, MPI_INT,
					recvbuff_elements, recvcount_elements, disp_elements,
					MPI_INT, ROOT, MPI_COMM_WORLD);
		V(cout << rank << "--> 2 Gatherv done" << endl;)

        //ROOT Process only
		if (rank == ROOT)
		{
			V(cout << "inside root" << endl;)

            //making cluster.centroid from recv centroid
			int i = 0;
			for (int j = 0; j < k; j++)
			{
				for (int jd = 0; jd < d; jd++)
				{
					clusters[j].centroid[jd] = centroid_recv_buff[i++];
				}
			}

            //adjusting size of elements
            int counter = 0;
            for (int j = 0; j < k; j++)
            {
                for (int i = 0; i < n/k; i++)
                {
                    while (true)
                    {
                        if (recvbuff_elements[counter] == -1)
                        {
                            counter++;
                        }
                        else
                        {
                            break;
                        }
                    }
                    if (recvbuff_elements[counter] != -1)
                        clusters[j].elements[i] = recvbuff_elements[counter++];
                }
            }

            //Accum call
            for (int i = 0; i < k; i++) 
            {
                int min = 0;
                for (int j = 1; j < k; j++)
                {
                    if (clusters[i].centroid[j] < clusters[i].centroid[min])
                        min = j;
                }
                accum(clusters[min].centroid, clusters[min].elements.size(), elements[i],0);
            }
		}
    }

    //bcastCentroids() function broadcast the centroids to all the processes so that they update their clusters
    virtual void bcastCentroids(int rank)
    {
        V(cout<<" "<<rank<<" bcastCentroids"<<endl;)
        int count = k * d;
        auto *buffer = new u_char[count];
        if(rank == ROOT)
        {
            int i = 0;
            for(int j = 0; j<k; j++)
                for(int jd = 0; jd < d; jd++)
                    buffer[i++] = clusters[j].centroid[jd];
            //V(cout<<" "<<rank<<" Sending Centroids:....";)
        }
        MPI_Bcast(buffer, count, MPI_UNSIGNED_CHAR, ROOT, MPI_COMM_WORLD);

        if (rank != ROOT)
        {
            int i = 0;
            for(int j = 0; j<k; j++)
                for(int jd = 0; jd < d; jd++)
                    clusters[j].centroid[jd] = buffer[i++];
            //V(cout<<" "<<rank<<" Received Centroids:....";) 
        }
        delete [] buffer;
    }
    /**
     * Get the initial cluster centroids.
     * Default implementation here is to just pick k elements at random from the element
     * set
     * @return list of clusters made by using k random elements as the initial centroids
     */
    virtual void reseedClusters() {
        std::vector<int> seeds;
        std::vector<int> candidates(n);
        std::iota(candidates.begin(), candidates.end(), 0);
        auto random = std::mt19937{std::random_device{}()};
        // Note that we need C++20 for std::sample
        std::sample(candidates.begin(), candidates.end(), back_inserter(seeds), k, random);
        for (int i = 0; i < k; i++) {
            clusters[i].centroid = elements[seeds[i]];
            clusters[i].elements.clear();
        }
    }

    /**
     * Calculate the distance from each element to each centroid.
     * Place into this->dist which is a k-vector of distances from each element to the kth centroid.
     */
    virtual void updateDistances(Element* partition, int recvsize, int rank) 
    {
        for (int i = 0; i < recvsize; i++) 
        {
            //V(cout<<rank<<"   distances for "<<i<<"(";for(int x=0;x<d;x++)printf("%02x",partition[i][x]);)
            for (int j = 0; j < k; j++) 
            {
                dist[i][j] = distance(clusters[j].centroid, partition[i]);
                //V(cout<<" " << dist[i][j];)
            }
            //V(cout<<endl;)
        }
    }

    /**
     * Recalculate the current clusters based on the new distances shown in this->dist.
     */
    virtual void updateClusters(int recvsize, Element* partition, int rank) {
        // reinitialize all the clusters
        for (int j = 0; j < k; j++) {
            clusters[j].centroid = Element{};
            clusters[j].elements.clear();
        }

        // for each element, put it in its closest cluster (updating the cluster's centroid as we go)
        for (int i = 0; i < recvsize; i++) {
            int min = 0;
            for (int j = 1; j < k; j++)
                if (dist[i][j] < dist[i][min])
                    min = j;
            accum(clusters[min].centroid, clusters[min].elements.size(), partition[i], 1);
            clusters[min].elements.push_back(i + (rank * recvsize));
        }
    }

    /**
     * Method to update a centroid with an additional element(s)
     * @param centroid   accumulating mean of the elements in a cluster so far
     * @param centroid_n number of elements in the cluster so far
     * @param addend     another element(s) to be added; if multiple, addend is their mean
     * @param addend_n   number of addends represented in the addend argument
     */
    virtual void accum(Element& centroid, int centroid_n, const Element& addend, int addend_n) const {
        int new_n = centroid_n + addend_n;
        for (int i = 0; i < d; i++) {
            double new_total = (double) centroid[i] * centroid_n + (double) addend[i] * addend_n;
            centroid[i] = (u_char)(new_total / new_n);
        }
    }

    /**
     * Subclass-supplied method to calculate the distance between two elements
     * @param a one element
     * @param b another element
     * @return distance from a to b (or more abstract metric); distance(a,b) >= 0.0 always
     */
    virtual double distance(const Element& a, const Element& b) const = 0;

};

