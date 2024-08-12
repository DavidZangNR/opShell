#!/bin/bash

GETH_DIR=`pwd`
NODE_DIR=${GETH_DIR}/../op-node-data
# Function to start processes
start_processes() {
    cd ${GETH_DIR}
    touch "" > ./nohup.out
    echo "start geth"
    nohup bash ./start-geth.sh &
    sleep 10
    echo "set HEAD"
    curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"debug_setHead","params":["0x5b1900"],"id":1}' http://localhost:8545
    sleep 20
    cd ${NODE_DIR}
    echo "start node"
    nohup bash ./start-node.sh >/dev/null 2>&1 &
    sleep 2
    cd $GETH_DIR
#    nohup process2 > nohup.out &
}

# Function to check nohup.out and handle conditions
check_nohup_out() {
    while true; do
    #    output=$(tail -n 2000 nohup.out)
        echo "in loop ... "
        if grep -q "badnumber" nohup.out; then
            echo "FAIL.....STOP!!"
            pkill --signal SIGINT op-node
            pkill --signal SIGINT op-geth
            sleep 10
            exit 1
        fi

        if grep -q "number=5,907,230" nohup.out; then
            echo "PASS....RESTART"
            pkill --signal SIGINT op-node
            pkill --signal SIGINT op-geth
            sleep 10  # Allow processes to terminate gracefully
            start_processes
        fi

        echo "loop checking ...."
        echo "log tail"
        tail -100 nohup.out
        echo ".........."
        sleep 2
    done
}

# Start processes and monitor nohup.out
start_processes
check_nohup_out
