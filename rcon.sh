#!/bin/bash
CurrentHome=$PWD
Directory=$2
IP=$3
Port=$4
Password=$5

qote='"'
file='"hours.txt"'

if [ "$1" = "Players" ]
then
$CurrentHome/mcrcon -H $IP -P $Port -p $Password '/players online' | sed -r "s/\x1B\[[0-9;]*[a-zA-Z]//g" | sed '1d' | sed 's/^..//' > $CurrentHome/playersonline.txt
onlineplayers=$(wc -l < $CurrentHome/playersonline.txt)
echo "<h2>Number of Online Players : $onlineplayers</h2>"
echo '<div id="PlayerList">'
echo '<table border="1">'
echo "<tr>"
echo "<td>Player Name</td>"
echo "<td>PlayTime (in hours, minutes)</td>"
echo "</tr>"
mkdir $Directory/script-output
while read playersonline; do
playerfixed=$( echo "${playersonline}" | sed 's/ (online)//g')
player="$qote${playerfixed}$qote"
$CurrentHome/mcrcon -c -H $IP -P $Port -p $Password "/silent-command game.write_file($file, game.players[$player].online_time / 60 / 3600, false, 0)"
time=`cat $Directory/script-output/hours.txt`
timehour=$( printf "%2.2f\n" $time)
echo "<tr><td>$playersonline</td><td>$timehour Hours</td></tr>"
done <$CurrentHome/playersonline.txt
$CurrentHome/mcrcon -H $IP -P $Port -p $Password '/players' | sed -r "s/\x1B\[[0-9;]*[a-zA-Z]//g" | sed '1d' | sed 's/^..//' > $CurrentHome/players.txt
while read players; do
if [[ $players == *"online"* ]]; then
	:
else
player="$qote${players}$qote"
$CurrentHome/mcrcon -c -H $IP -P $Port -p $Password "/silent-command game.write_file($file, game.players[$player].online_time / 60 / 3600, false, 0)"
time=`cat $Directory/script-output/hours.txt`
timehour=$( printf "%2.2f\n" $time)
echo "<tr><td>$players</td><td>$timehour Hours</td></tr>"
fi
done <$CurrentHome/players.txt
echo "</table>"
echo "</div>"

fi
