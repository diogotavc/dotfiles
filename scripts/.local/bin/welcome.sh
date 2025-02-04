#!/bin/bash

# almost direct translation of the go source code of the welcome binary - thanks gpt :)
# (without the first portion, where it greets the current user)
# the go source code is old and atrocious, needs a ton of rewriting and so on
# it will be available sometime I promise lol

consumptionString() {
    local consumption=( $(Consumption) ) # consumption[0]: status, [1]: quotient, [2]: remainder
    if [[ "${consumption[0]}" == "Charging" || "${consumption[0]}" == "Discharging" ]]; then
        printf "🗲  %s at about %s.%s Watts\n" "${consumption[0]}" "${consumption[1]}" "${consumption[2]}"
    else
        printf "🗲  %s\n" "${consumption[0]}"
    fi
}

Consumption() {
    local status consumption first second
    status=$(cat "$(detectBattery)/status") || { echo "Error reading battery status"; exit 1; }
    status=${status//$'\n'/}
    consumption=$(getPowerConsumption)
    first=$(( consumption / 10 ))
    second=$(( consumption % 10 ))
    echo "$status" "$first" "$second"
}

detectBattery() {
    local subpath="/sys/class/power_supply"
    for bat in "BAT0" "BAT1" "BAT2"; do
        if [ -d "$subpath/$bat" ]; then
            echo "$subpath/$bat"
            return
        fi
    done
    echo ""
}

checkError() {
    local exit_code=$1
    if [ $exit_code -ne 0 ]; then
        echo "Error encountered (exit code $exit_code)" >&2
        exit $exit_code
    fi
}

readInt() {
    local filename="$1"
    local content
    content=$(cat "$filename") || { echo "Error reading $filename"; exit 1; }
    # Trim whitespace and convert to integer
    echo $(( $(echo "$content" | tr -d '[:space:]') ))
}

getPowerConsumption() {
    local batteryPath
    batteryPath=$(detectBattery)
    local powerPath="${batteryPath}/power_now"
    local currentPath="${batteryPath}/current_now"
    local energyPath="${batteryPath}/energy_now"
    if [ -f "$powerPath" ]; then
        local power
        power=$(readInt "$powerPath")
        echo $(( power / 100000 ))
    elif [ ! -f "$powerPath" ]; then
        local current energy
        current=$(readInt "$currentPath")
        energy=$(readInt "$energyPath")
        echo $(( (current * energy) / 100000 ))
    else
        echo 0
    fi
}

consumptionString
