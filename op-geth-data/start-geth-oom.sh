#! /usr/bin/bash
#cd $OPBNB_WORKSPACE

# for testnet
#export CHAIN_ID=5611
#export L2_RPC=https://opbnb-testnet-rpc.bnbchain.org
#export P2P_BOOTNODES="enr:-KO4QKFOBDW--pF4pFwv3Al_jiLOITj_Y5mr1Ajyy2yxHpFtNcBfkZEkvWUxAKXQjWALZEFxYHooU88JClyzA00e8YeGAYtBOOZig2V0aMfGhE0ZYGqAgmlkgnY0gmlwhDREiqaJc2VjcDI1NmsxoQM8pC_6wwTr5N2Q-yXQ1KGKsgz9i9EPLk8Ata65pUyYG4RzbmFwwIN0Y3CCdl-DdWRwgnZf,enr:-KO4QFJc0KR09ye818GT2kyN9y6BAGjhz77sYimxn85jJf2hOrNqg4X0b0EsS-_ssdkzVpavqh6oMX7W5Y81xMRuEayGAYtBSiK9g2V0aMfGhE0ZYGqAgmlkgnY0gmlwhANzx96Jc2VjcDI1NmsxoQPwA1XHfWGd4umIt7j3Fc7hKq_35izIWT_9yiN_tX8lR4RzbmFwwIN0Y3CCdl-DdWRwgnZf"

# for mainnet
export CHAIN_ID=204
export L2_RPC=https://opbnb-mainnet-rpc.bnbchain.org
export P2P_BOOTNODES="enr:-KO4QHs5qh_kPFcjMgqkuN9dbxXT4C5Cjad4SAheaUxveCbJQ3XdeMMDHeHilHyqisyYQAByfdhzyKAdUp2SvyzWeBqGAYvRDf80g2V0aMfGhHFtSjqAgmlkgnY0gmlwhDaykUmJc2VjcDI1NmsxoQJUevTL3hJwj21IT2GC6VaNqVQEsJFPtNtO-ld5QTNCfIRzbmFwwIN0Y3CCdl-DdWRwgnZf,enr:-KO4QKIByq-YMjs6IL2YCNZEmlo3dKWNOy4B6sdqE3gjOrXeKdNbwZZGK_JzT1epqCFs3mujjg2vO1lrZLzLy4Rl7PyGAYvRA8bEg2V0aMfGhHFtSjqAgmlkgnY0gmlwhDbjSM6Jc2VjcDI1NmsxoQNQhJ5pqCPnTbK92gEc2F98y-u1OgZVAI1Msx-UiHezY4RzbmFwwIN0Y3CCdl-DdWRwgnZf"

# --log.file="./geth.log"
# --maxpeers=10
# --miner.gaslimit=150000000
#  --parallel.trustdag=true \

./op-geth \
  --datadir="./datadir" \
  --verbosity=4 \
  --http \
  --http.corsdomain="*" \
  --http.vhosts="*" \
  --http.addr=0.0.0.0 \
  --http.port=8545 \
  --http.api=net,eth,engine,debug \
  --pprof \
  --pprof.port=6070 \
  --ws \
  --ws.addr=0.0.0.0 \
  --ws.port=8545 \
  --ws.origins="*" \
  --ws.api=eth,engine \
  --syncmode=full \
  --networkid=$CHAIN_ID \
  --txpool.globalslots=20000 \
  --txpool.globalqueue=5000 \
  --txpool.accountqueue=200 \
  --txpool.accountslots=200 \
  --txpool.nolocals=true \
  --txpool.pricelimit=1 \
  --cache 32000 \
  --cache.preimages \
  --allow-insecure-unlock \
  --authrpc.addr="0.0.0.0" \
  --authrpc.port="8551" \
  --authrpc.vhosts="*" \
  --authrpc.jwtsecret=./jwt.txt \
  --rpc.allow-unprotected-txs \
  --parallel \
  --parallel.txdag \
  --parallel.txdagfile=./parallel-txdag-output.csv \
  --parallel.unordered-merge \
  --gcmode=archive \
  --metrics \
  --metrics.port 6068 \
  --metrics.addr 0.0.0.0 \
  --rollup.sequencerhttp=$L2_RPC \
  --rollup.disabletxpoolgossip=false \
  --bootnodes=$P2P_BOOTNODES 

# --parallel.num=16 \

