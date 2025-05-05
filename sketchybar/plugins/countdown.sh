#!/bin/sh

# --- Configuration ---

# Work hours end / Rest hours start
TARGET_HOUR_WORK_END=21 # 9pm
TARGET_MINUTE_WORK_END=00
TARGET_SECOND_WORK_END=00

# Rest hours end / Work hours start
TARGET_HOUR_WORK_START=9 # 9am
TARGET_MINUTE_WORK_START=00
TARGET_SECOND_WORK_START=00

# --- Logic ---
NOW_TS=$(date "+%s")
CURRENT_HOUR=$(date "+%H") # Get current hour (00-23)

TODAY=$(date "+%Y-%m-%d")

# Calculate potential target timestamps using macOS date syntax
TARGET_DATETIME_WORK_END_TODAY="${TODAY} ${TARGET_HOUR_WORK_END}:${TARGET_MINUTE_WORK_END}:${TARGET_SECOND_WORK_END}"
TARGET_TS_WORK_END_TODAY=$(date -j -f "%Y-%m-%d %H:%M:%S" "${TARGET_DATETIME_WORK_END_TODAY}" "+%s" 2>/dev/null)

# Calculate 9am today and 9am tomorrow timestamps
TARGET_DATETIME_WORK_START_TODAY="${TODAY} ${TARGET_HOUR_WORK_START}:${TARGET_MINUTE_WORK_START}:${TARGET_SECOND_WORK_START}"
TARGET_TS_WORK_START_TODAY=$(date -j -f "%Y-%m-%d %H:%M:%S" "${TARGET_DATETIME_WORK_START_TODAY}" "+%s" 2>/dev/null)

TOMORROW=$(date -v+1d "+%Y-%m-%d") # macOS specific way to get tomorrow
TARGET_DATETIME_WORK_START_TOMORROW="${TOMORROW} ${TARGET_HOUR_WORK_START}:${TARGET_MINUTE_WORK_START}:${TARGET_SECOND_WORK_START}"
TARGET_TS_WORK_START_TOMORROW=$(date -j -f "%Y-%m-%d %H:%M:%S" "${TARGET_DATETIME_WORK_START_TOMORROW}" "+%s" 2>/dev/null)


# Check for date conversion errors (checking the last one is usually sufficient)
if [[ $? -ne 0 ]]; then
  echo "􀇿 Error" # Use an error icon
  # Optionally set sketchybar label to error state
  # sketchybar --set $NAME label="􀇿 Error"
  exit 1
fi

# Determine the correct target timestamp
if [[ "$CURRENT_HOUR" -ge $TARGET_HOUR_WORK_START && "$CURRENT_HOUR" -lt $TARGET_HOUR_WORK_END ]]; then
    # Currently between 9am and 9pm (exclusive of 9pm): target is 9pm today
    TARGET_TS=$TARGET_TS_WORK_END_TODAY
else
    # Currently between 9pm and 9am (inclusive of 9pm, exclusive of 9am): target is 9am next
    # If it's currently before 9am today, the target is 9am today.
    # Otherwise (it must be 9pm or later today), the target is 9am tomorrow.
    if [[ "$NOW_TS" -lt "$TARGET_TS_WORK_START_TODAY" ]]; then
        TARGET_TS=$TARGET_TS_WORK_START_TODAY
    else
        TARGET_TS=$TARGET_TS_WORK_START_TOMORROW
    fi
fi

REMAINING_S=$((TARGET_TS - NOW_TS))

# Ensure remaining seconds isn't negative (handles edge case if script runs exactly at target time)
if [[ "$REMAINING_S" -lt 0 ]]; then
  REMAINING_S=0
fi

# --- Icon Logic (Based on Current Hour for Simplicity) ---
# This logic provides an icon relevant to the time of day
ICON="?" 
if [[ "$CURRENT_HOUR" -ge 6 && "$CURRENT_HOUR" -lt 12 ]]; then  # 6am - 11:59am (Morning)
    ICON="􀆱" # Sun Rise / Morning Sun
elif [[ "$CURRENT_HOUR" -ge 12 && "$CURRENT_HOUR" -lt 18 ]]; then # 12pm - 5:59pm (Afternoon)
    ICON="􀆭" # Sun High / Afternoon
elif [[ "$CURRENT_HOUR" -ge 18 && "$CURRENT_HOUR" -lt 21 ]]; then # 6pm - 8:59pm (Evening)
    ICON="􀆳" # Sun Set / Evening
else # 9pm - 5:59am (Night)
    ICON="􀆹" # Moon / Night
fi

# Calculate hours, minutes, seconds from remaining seconds
HOURS=$((REMAINING_S / 3600))
MINUTES=$(( (REMAINING_S % 3600) / 60 ))
SECONDS=$((REMAINING_S % 60))

# Format the output string as ICON HH:MM:SS
RESPONSE=$(printf "%s %02d:%02d" "$ICON" $HOURS $MINUTES)

sketchybar --set $NAME label="$RESPONSE"