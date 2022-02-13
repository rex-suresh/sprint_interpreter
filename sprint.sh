function print_cells() {
  cell_index

  echo -n "CELL VALUES|"
  for cell in ${SPRINT_ARRAY[@]}
  do
    echo -n "${cell}|"
  done
  echo ""
}

function cell_index() {
  local cell_count=${#SPRINT_ARRAY[@]}
  local position=0
  echo -n "CELL POSITION|"
  while [[ ${position} -lt ${cell_count} ]]
  do
    echo -n "${position}|"
    position=$(( ${position} + 1 ))
  done
  echo ""
}

function logic_add() {
  local source_cell_1=$1
  local source_cell_2=$2
  local destination_cell=$3

  local cell_value_1=${SPRINT_ARRAY[${source_cell_1}]}
  local cell_value_2=${SPRINT_ARRAY[${source_cell_2}]}

  local sum_value=$(( ${cell_value_1} + ${cell_value_2} ))

  SPRINT_ARRAY[${destination_cell}]="${sum_value}"
  LOGIC_POSITION=$(( ${LOGIC_POSITION} + 4 ))
}

function logic_compare() {
  local source_cell_1=$1
  local source_cell_2=$2
  local destination_cell=$3

  local cell_value_1=${SPRINT_ARRAY[${source_cell_1}]}
  local cell_value_2=${SPRINT_ARRAY[${source_cell_2}]}

  if [[ ${cell_value_1} -lt ${cell_value_2} ]]
  then
    LOGIC_POSITION=${destination_cell}
    return 0
  fi
  LOGIC_POSITION=$(( ${LOGIC_POSITION} + 4 ))
}

function interpret_logic() {
  local logic=$1

  local source_cell_1=$(( ${LOGIC_POSITION} + 1 ))
  local source_cell_2=$(( ${LOGIC_POSITION} + 2 ))
  local destination_cell=$(( ${LOGIC_POSITION} + 3 ))
  
  local source_cell_value_1=${SPRINT_ARRAY[${source_cell_1}]}
  local source_cell_value_2=${SPRINT_ARRAY[${source_cell_2}]}
  local destination_cell_value=${SPRINT_ARRAY[${destination_cell}]}

  if [[ ${logic} == 1 ]]
  then 
    logic_add "${source_cell_value_1}" "${source_cell_value_2}" "${destination_cell_value}"
  elif [[ ${logic} == 2 ]]
  then
    logic_compare "${source_cell_value_1}" "${source_cell_value_2}" "${destination_cell_value}"
  fi
  local logic=${SPRINT_ARRAY[${LOGIC_POSITION}]}

  return "${logic}"
}

function main() {
  local logic=${SPRINT_ARRAY[${LOGIC_POSITION}]}
  until [[ "${logic}" == "99" ]]
  do
    interpret_logic "${logic}"
    logic=$?
  done
  print_cells | column -ts"|"
}