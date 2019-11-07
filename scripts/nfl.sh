#!/bin/bash
#This script was written on August 27, 2011 by Kyle R. Jones (kr.jones@me.com)
#Place any number of teams into the team list. This list is then parsed from "http://    www.nfl.com/liveupdate/scorestrip/ss.xml"
#for the current score. My intended goal is to use this with geektool.

# SELECT the teams that you want to follow from the list below.
# ARI ATL BA BUF CAR CHI CIN CLE DAL DEN DET GB HOU IND JAC KC MIA MIN NE NO NYG NYJ OAK PHI PIT SD SEA SF STL TB TEN WAS

##### Place team abbreviation BELOW ######
#team=(DAL DEN PHI NYG WAS)
team=(ARI ATL BA BUF CAR CHI CIN CLE DAL DEN DET GB HOU IND JAC KC MIA MIN NE NO NYG NYJ OAK PHI PIT SD SEA SF STL TB TEN WAS)

# Select Time Zone ########
# Supported Time Zones ("Pacific", "Mountain", "Central", "Eastern")
    timezone="Mountain"

## This first for loop goes through all of the teams in the list and finds who they are playing. In some cases
## two of the listed teams are playing one another. In this case we have to sort the list and find only unique pairs.

curl -s http://www.nfl.com/liveupdate/scorestrip/ss.xml > ~/.temp.txt

# Week Number
week=`cat ~/.temp.txt | grep "gms w"  | sed -e 's/.*w="\([^"]*\)".*/\1/'`
year=`cat ~/.temp.txt | grep "gms w"  | sed -e 's/.*y="\([^"]*\)".*/\1/'`
echo -e "\n=========="
echo -e "NFL "$year" Week: "$week
echo -e "==========\n"

for i in ${team[@]}; do
# Downloads the data for the home and visiting city
home_city=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*h="\([^"]*\)".*/\1/'`
visiting_city=`cat ~/.temp.txt | grep ${i} | sed -e 's/.*v="\([^"]*\)".*/\1/'`

# Downloads the data for the home and visiting teams
home_team=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*hnn="\([^"]*\)".*/\1/'`
visiting_team=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*vnn="\([^"]*\)".*/\1/'`

# Capitalizes the team names
first=`echo ${home_team} | sed 's/\(.\).*/\1/'`
last=`echo ${home_team} | sed 's/.\(.*\)/\1/'`
upper=`echo ${first} | tr '[a-z]' '[A-Z]'`
home_team="$upper$last"

# Capitalizes the team names
first=`echo ${visiting_team} | sed 's/\(.\).*/\1/'`
last=`echo ${visiting_team} | sed 's/.\(.*\)/\1/'`
upper=`echo ${first} | tr '[a-z]' '[A-Z]'`
visiting_team="$upper$last"


# Creates a home/visitor pair and if the team has a two letter abbreviation it places it second (i.e. GB and DAL would become DALGB, otherwise they are as follows: DALNYG
if [ ${#home_city}  -lt 3 ]; then
    tms=("${tms[@]}" $visiting_city$home_city)
else
    tms=("${tms[@]}" $home_city$visiting_city)
fi

done

# Creates a new sorted array of the team pairs
arr2=( $(
for el in "${tms[@]}"
do
echo "$el"
done | sort -u) )


# This was to create the array to send to the next for loop but didn't take into account an instance where a two letter team played another two
# letter team (i.e. GB vs. NE). The cut -c "1-3" wouldn't work and thus wouldn't pass on the correct team abbreviation.
#arr3=( $(
#    for el in "${arr2[@]}"
#    do
#        echo "$el"
#    done | cut -c "1-3") )


# This allows two two-letter teams play one another (i.e. GB vs. NE). I haven't tested this yet. If it doesn't work let me know.
for el in ${arr2[@]}; do
if [ ${#el}  -lt 5 ]; then
    tmp=`echo "$el" | cut -c "1-2"`
    arr3=("${arr3[@]}" $tmp)
else
    tmp=`echo "$el" | cut -c "1-3"`
    arr3=("${arr3[@]}" $tmp)
fi
done


### This section does work.

for i in ${arr3[@]}; do

# Downloads the data for the home and visiting city
home_city=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*h="\([^"]*\)".*/\1/'`
visiting_city=`cat ~/.temp.txt | grep ${i} | sed -e 's/.*v="\([^"]*\)".*/\1/'`

# Downloads the data for the home and visiting teams
home_team=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*hnn="\([^"]*\)".*/\1/'`
visiting_team=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*vnn="\([^"]*\)".*/\1/'`

# Capitalizes the team names
first=`echo ${home_team} | sed 's/\(.\).*/\1/'`
last=`echo ${home_team} | sed 's/.\(.*\)/\1/'`
upper=`echo ${first} | tr '[a-z]' '[A-Z]'`
home_team="$upper$last"

# Capitalizes the team names
first=`echo ${visiting_team} | sed 's/\(.\).*/\1/'`
last=`echo ${visiting_team} | sed 's/.\(.*\)/\1/'`
upper=`echo ${first} | tr '[a-z]' '[A-Z]'`
visiting_team="$upper$last"

# This section finds the home and visiting scores
home_score=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*hs="\([^"]*\)".*/\1/'`
visiting_score=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*vs="\([^"]*\)".*/\1/'`

# This section finds what quarter the game is in and how much time left
quarter=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*q="\([^"]*\)".*/\1/'`
time_left=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*k="\([^"]*\)".*/\1/'`

# This finds the day and time
day=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.*d="\([^"]*\)".*/\1/'`
time=`cat ~/.temp.txt | grep ${i}  | sed -e 's/.* t="\([^"]*\)".*/\1/'`


# Split out hour and minute
if [ ${#time}  -lt 5 ]; then
    hour=`echo "$time" | cut -c "1-1"`
    minute=`echo "$time" | cut -c "3-4"`

else
    hour=`echo "$time" | cut -c "1-2"`
    minute=`echo "$time" | cut -c "4-5"`
fi

# Convert to different timezone
DSTYN=`date +%Z | cut -c 2-2`
if [ $timezone = "Pacific" ]; then
    hour=$(($hour + 12 - 3))
    if [ $DSTYN = "D" ]; then
        zone="PDT"
    else
        zone="PST"
    fi
elif [ $timezone = "Mountain" ]; then
    hour=$(($hour + 12 - 2))
    if [ $DSTYN = "D" ]; then
        zone="MDT"
    else
        zone="MST"
    fi
elif [ $timezone = "Central" ]; then
    hour=$(($hour + 12 - 1))
    if [ $DSTYN = "D" ]; then
        zone="CDT"
    else
        zone="CST"
    fi
elif [ $timezone = "Eastern" ]; then
    if [ $DSTYN = "D" ]; then
        zone="EDT"
    else
        zone="EST"
    fi
fi

if [ $hour -gt 12 ]; then
    hour=$((hour - 12))
fi

time=$hour":"$minute" "$zone

# This section does a little logic to make display the proper status of the game or future games
if [ $quarter = "F" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} FINAL
elif [ $quarter = "P" ]; then
echo ${visiting_city} ${visiting_team} at ${home_city} ${home_team} on $day at $time $zone_label
elif [ $quarter = "H" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} HALFTIME
elif [ $quarter = "FO" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} FINAL IN OVERTIME
else
if [ $quarter = "1" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}st
elif [ $quarter = "2" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}nd
elif [ $quarter = "3" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}rd
elif [ $quarter = "3" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in the ${quarter}th
elif [ $quarter = "O" ]; then
echo ${visiting_city} ${visiting_team} ${visiting_score} ${home_city} ${home_team} ${home_score} with ${time_left} in overtime
fi
fi

done
rm ~/.temp.txt
