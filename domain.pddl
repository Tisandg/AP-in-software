(define (domain software-development-process)
(:requirements :typing :action-costs)
(:types roles - object
        developer tester - roles
        dev_jr dev_ssr dev_sr - developer
        tester_jr tester_ssr tester_sr - tester
        project task state - object
        state-project state-task state-roles - state
)
(:predicates 
  (task-in ?t - task ?s - state-task)
  (role-is ?r - roles ?s - state-roles)
  (assigned-to ?t - task ?r - roles)
  (next ?s1 - state ?s2 - state)
  (can-assign ?t - task ?s - state-task)
  (can-develop ?t - task ?s - state-task)
  (can-test ?t - task ?s - state-task)
  (can-finalize ?t - task ?s - state-task)
)

(:functions (total-cost) - number
            (work-fast ?dev - developer ?t - task) - number
            (work-medium ?dev - developer ?t - task) - number
            (work-slow ?dev - developer ?t - task) - number
            (test-fast ?testman - tester ?t - task) - number
            (test-medium ?testman - tester ?t - task) - number
            (test-slow ?testman - tester ?t - task) - number
)

(:action assign_developer_to_task
  :parameters (?dev - developer ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles )
  :precondition (and (role-is ?dev ?free)  (not(role-is ?dev ?bussy))  (not(assigned-to ?t ?dev))  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-assign ?t ?previous_s)  (next ?previous_s ?next_s))
  :effect (and (role-is ?dev ?bussy) (not(role-is ?dev ?free)) (assigned-to ?t ?dev) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) )
)

(:action develop_task_slow
  :parameters (?dev - dev_jr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-develop ?t ?previous_s)  (next ?previous_s ?next_s))
  :effect ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ?dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (increase (total-cost) (work-slow ?previous_s ?next_s)) )
)

(:action develop_task_medium
  :parameters (?dev - dev_ssr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-develop ?t ?previous_s)  (next ?previous_s ?next_s))
  :effect ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ?dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (increase (total-cost) (work-medium ?previous_s ?next_s)) )
)

(:action develop_task_fast
  :parameters (?dev - dev_sr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-develop ?t ?previous_s) (next ?previous_s ?next_s) )
  :effect ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ?dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (increase (total-cost) (work-fast ?previous_s ?next_s)) )
)

(:action assign_tester_to_task
  :parameters (?testerman - tester ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?testerman ?free)  (not(role-is ?testerman ?bussy))  (not(assigned-to ?t ?testerman))  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s)) (next ?previous_s ?next_s) (can-test ?t ?previous_s))
  :effect (and (role-is ?testerman ?bussy) (not(role-is ?testerman ?free)) (assigned-to ?t ?testerman) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) )
)

(:action test_task_slow
  :parameters (?testerman - tester_jr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-finalize ?t ?previous_s) (next ?previous_s ?next_s))
  :effect ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (increase (total-cost) (test-slow ?previous_s ?next_s)) )
)

(:action test_task_medium
  :parameters (?testerman - tester_ssr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition (and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-finalize ?t ?previous_s)  (next ?previous_s ?next_s) )
  :effect ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (increase (total-cost) (test-medium ?previous_s ?next_s)) )
)

(:action test_task_fast
  :parameters (?testerman - tester_sr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
  :precondition ( and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s)) (can-finalize ?t ?previous_s) (next ?previous_s ?next_s) )
  :effect ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (increase (total-cost) (test-fast ?previous_s ?next_s)) )
)

)
