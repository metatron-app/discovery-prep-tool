#!/bin/bash

./preptool -f ~/data/s5k_1.csv
./preptool -f ~/data/s5k_1.csv -n "Sales data 5000 rows (1/4)"
./preptool -q "select * from test.t" -c "MySQL" -n "DB test dataset"
./preptool -F multi -o sales_2011_02 -n sales_2011_3

#eof
