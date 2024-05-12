# MPI Dockerfile
FROM nersc/ubuntu-mpi:22.10

ADD helloworld.c /app/

RUN cd /app && mpicc helloworld.c -o /app/hello
