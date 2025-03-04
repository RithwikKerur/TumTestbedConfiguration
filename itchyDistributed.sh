#!/bin/bash
rm -rf TumTestbedConfiguration
git clone https://github.com/RithwikKerur/TumTestbedConfiguration.git
cd SailfishTest
cargo build --quiet --release --features benchmark
cd ./target/release
tmux new -d -s primary "./node -vvv run --keys /root/TumTestbedConfiguration/node-2.json --committee /root/TumTestbedConfiguration/committee.json --store ./db-2 --parameters /root/TumTestbedConfiguration/parameters.json primary |& tee primary.log"
tmux new -d -s client "./benchmark_client 172.16.6.1:3004 --size 512 --burst 50 --rate 10000 --nodes 172.16.3.1:3004 172.16.1.1:3004 172.16.6.1:3004 2>&1 | tee client.log"
tmux new -d -s worker "./node -vvv run --keys /root/TumTestbedConfiguration/node-2.json --committee /root/TumTestbedConfiguration/committee.json --store ./db-2-0 --parameters /root/TumTestbedConfiguration/parameters.json worker --id 0 2>&1 | tee worker.log"
tmux ls
pos_sync
sleep 40
echo "finished running primary"
ls
tmux kill-session -t primary
tmux kill-session -t client
tmux kill-session -t worker
cat primary.log
echo "client log"
cat client.log
echo "worker log"
cat worker.log
pos_upload -f worker.log
pos_upload -f client.log
pos_upload -f primary.log
