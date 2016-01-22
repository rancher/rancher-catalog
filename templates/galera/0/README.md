# Galera Cluser (Experimental)

### Info:

This template creates a MariaDB Galera cluster on top of Rancher. Using the Galera plugin the MariaDB cluster runs in a multi-master replicated mode. 

When deployed from the catalog, a three node cluster is created with a database, root password, database user and password. The cluster is setup for replication between all of the nodes. The cluster sits behind a light weight proxy layer that forwards all reads/writes to a single server. This is done so that transaction locks will work. The proxy layer is then fronted by a Rancher load balance. 

Clients should access the cluster through the load balancer so they do not need to be updated in the event of a failure. 

When the cluster is completely stopped and started, user intervention is required to bring it back online. Instructions can be found in the [Galera documentation](http://galeracluster.com/documentation-webpages/quorumreset.html).

The replication mechanism used in the cluster is based on the MySQL dump method. This is has the side effect of taking a long time to bring in a new node when there are large data sets.

### Usage:

Once deployed, use a mysql client to connect:

`mysql -u<db_user> -p -h<galera-lb>`