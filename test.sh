#!/bin/bash

./preptool -s ~/data/s5k_1.csv
./preptool -q "select * from test.t" --search-connection "MySQL" -i "DB test dataset"
./preptool --search-wds "anonymous" | head -1
./preptool --search-connection "MySQL" | head -1

#eof
