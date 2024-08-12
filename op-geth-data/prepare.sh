export OPBNB_WORKSPACE=/media/linux/opbnb-node
cd $OPBNB_WORKSPACE
# for testnet
cp $OPBNB_WORKSPACE/opbnb/assets/testnet/genesis.json $OPBNB_WORKSPACE/op-geth-data
# for mainnet
# cp $OPBNB_WORKSPACE/opbnb/assets/mainnet/genesis.json $OPBNB_WORKSPACE/op-geth-data

openssl rand -hex 32 > jwt.txt
cp jwt.txt $OPBNB_WORKSPACE/op-geth-data
cp jwt.txt $OPBNB_WORKSPACE/op-node-data

# init op-geth genesis
cd $OPBNB_WORKSPACE/op-geth-data
mkdir datadir
./op-geth --datadir ./datadir init genesis.json
