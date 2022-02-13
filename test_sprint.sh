#! /bin/bash
source sprint.sh
source testing_utilities.sh

function test_case_logic_add_array_modification() {
  SPRINT_ARRAY=(1 0 1 4 0) # ADDITION
  LOGIC_POSITION=0

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="1 0 1 4 1"
  local actual_output="`logic_add 0 1 4 ; echo ${SPRINT_ARRAY[@]}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should add cell values and modify array at destination cell with sum."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_case_logic_add_logic_position_modification() {
  SPRINT_ARRAY=(1 0 1 1 2) # ADDITION
  LOGIC_POSITION=0

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="4"
  local actual_output="`logic_add 0 1 2 ; echo ${LOGIC_POSITION}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should modify the logic position - array index value."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_logic_add() {
  test_case_logic_add_array_modification
  test_case_logic_add_logic_position_modification
}

function test_case_logic_compare_logic_position_modification() {
  SPRINT_ARRAY=(2 0 1 5 9 1) # COMPARE
  LOGIC_POSITION=0

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="4"
  local actual_output="`logic_compare 0 1 5 ; echo ${LOGIC_POSITION}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should modify the logic position index when escaped the 4 cells."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_case_logic_compare_logic_position_change() {
  SPRINT_ARRAY=(2 1 0 5 9 1) # COMPARE
  LOGIC_POSITION=0

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="5"
  local actual_output="`logic_compare 1 0 5 ; echo ${LOGIC_POSITION}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should change the logic position index when escaped the 4 cells."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_logic_compare() {
  test_case_logic_compare_logic_position_modification
  test_case_logic_compare_logic_position_change
}

function test_case_interpret_logic_add() {
  SPRINT_ARRAY=(1 0 1 4 0) # ADDITION
  LOGIC_POSITION=0

  local logic=1
  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="1 0 1 4 1"
  local actual_output="`interpret_logic ${logic} ; echo ${SPRINT_ARRAY[@]}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should call logic_add function."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_case_interpret_logic_compare() {
  SPRINT_ARRAY=(2 1 0 5 9 1) # COMPARE
  LOGIC_POSITION=0

  local logic=2
  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="5"
  local actual_output="`interpret_logic ${logic} ; echo ${LOGIC_POSITION}`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should call logic_compare function."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_case_interpret_logic_return() {
  SPRINT_ARRAY=(2 1 0 5 9 1) # COMPARE
  LOGIC_POSITION=3
  
  local logic=5
  local inputs="DATA : ${logic}"
  local expected_output="5"
  local actual_output="`interpret_logic ${logic} ; echo $?`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should return the logic value."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_interpret_logic() {
  test_case_interpret_logic_add
  test_case_interpret_logic_compare
  test_case_interpret_logic_return
}

function test_cell_index() {
  SPRINT_ARRAY=(1 8 7 6 5)

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="CELL POSITION|0|1|2|3|4|"
  local actual_output="`cell_index`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should output cell index values."
  
  local test_result=$?
  update_result "${test_result}"
}
function test_print_cells() {
  SPRINT_ARRAY=(1 8 7 6 5)

  local inputs="DATA : ${SPRINT_ARRAY[@]}"
  local expected_output="`echo -e "CELL POSITION|0|1|2|3|4|\nCELL VALUES|1|8|7|6|5|"`"
  local actual_output="`print_cells`"

  assert "${inputs}" "${expected_output}" "${actual_output}" "Should output cell index values."
  
  local test_result=$?
  update_result "${test_result}"
}

function test_main() {
  SPRINT_ARRAY=(1 5 6 7 99 20 33 0)
  LOGIC_POSITION=0

  local expected_output="`echo -e "CELL POSITION|0|1|2|3|4|5|6|7|\nCELL VALUES|1|5|6|7|99|20|33|53|" | column -ts"|" `"
  local actual_output="`main`"
  
  assert "${inputs}" "${expected_output}" "${actual_output}" "Should output cell index values."
  
  local test_result=$?
  update_result "${test_result}"
}

function all_tests() {
  heading "Logic_add"
  test_logic_add

  heading "Logic_compare"
  test_logic_compare
  
  heading "Interpret_logic"
  test_interpret_logic

  heading "Cell_index"
  test_cell_index
  
  heading "Print_cells"
  test_print_cells
  
  heading "Main"
  test_main

}

all_tests
display_tests_summary "${RESULT[@]}"