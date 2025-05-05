#!/usr/bin/env bash

API_URL="https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$NAME"

PRICE=""
CHANGE=""
{
  read -r PRICE
  read -r CHANGE
} < <(curl -s "$API_URL" | jq -r '.[0] | .current_price, .price_change_percentage_24h')

if [ -z "$PRICE" ] || [ -z "$CHANGE" ]; then
  printf "SOL $--- (---%%)\n"
  exit 0
fi

if ! [[ "$PRICE" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$CHANGE" =~ ^[-+]?[0-9]+(\.[0-9]+)?$ ]]; then
  printf "SOL $--- (---%%)\n"
  exit 0
fi

INDICATOR=""
if (( $(echo "$CHANGE > 0" | bc -l) )); then
  INDICATOR="􀓂" # Up
elif (( $(echo "$CHANGE < 0" | bc -l) )); then
  INDICATOR="􀓃" # Down
fi

# price w/ change
# RESPONSE=$(printf "$%.2f (%s%.2f%%)\n" "$PRICE" "$INDICATOR" "$CHANGE")

# price w/o change
RESPONSE=$(printf "$%'.2f" "$PRICE")
sketchybar --set $NAME label="$RESPONSE"
