#! /bin/bash

free -m | awk 'NR==2 {printf("USE: %.f Free: %.2f%\n"),$3, $3/$2*100}'
