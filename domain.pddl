(define (domain software-development-process)
(:requirements :typing :action-costs)
(:types roles - object
        developer tester - roles
        dev_jr dev_ssr dev_sr - developer
        tester_jr tester_ssr tester_sr - tester
        task state - object
        state-task state-roles - state
)
(:predicates 
  (next ?s1 - state ?s2 - state)
  (role-is ?r - roles ?s - state-roles)
  (can-assign ?t - task ?s - state-task)
  (can-develop ?t - task ?s - state-task)
  (can-test ?t - task ?s - state-task)
  (can-finalize ?t - task ?s - state-task)
  (task-in ?t - task ?s - state-task)
  (assigned-to ?t - task ?r - roles)
)

(:functions (total-cost) - number
            (work-fast   ?dev - developer ?t - task) - number
            (work-medium ?dev - developer ?t - task) - number
            (work-slow   ?dev - developer ?t - task) - number
            (test-fast   ?testman - tester ?t - task) - number
            (test-medium ?testman - tester ?t - task) - number
            (test-slow   ?testman - tester ?t - task) - number
)

(:action assign_developer_to_task
  :parameters (?dev - developer ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and 
    (task-in ?t ?previous_s)
    (can-assign ?t ?previous_s)
    (can-develop ?t ?next_s)
    (next ?previous_s ?next_s)
    (role-is ?dev ?free)
  )
  :effect (and 
    (task-in ?t ?next_s) (not (task-in ?t ?previous_s))
    (assigned-to ?t ?dev) (not(role-is ?dev ?free))
  )
)

(:action develop_task_slow
  :parameters (?dev - dev_jr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?dev)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-develop ?t ?previous_s)
  )
  :effect (and
    (role-is ?dev ?free)
    (not (assigned-to ?t ?dev))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (work-slow ?dev ?t))
  )
)

(:action develop_task_medium
  :parameters (?dev - dev_ssr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?dev)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-develop ?t ?previous_s)
  )
  :effect (and
    (role-is ?dev ?free)
    (not (assigned-to ?t ?dev))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (work-medium ?dev ?t))
  )
)

(:action develop_task_fast
  :parameters (?dev - dev_sr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?dev)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-develop ?t ?previous_s)
  )
  :effect (and
    (role-is ?dev ?free)
    (not (assigned-to ?t ?dev))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (work-fast ?dev ?t)) )
)

(:action assign_tester_to_task
  :parameters (?testerman - tester ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-test ?t ?previous_s)
    (role-is ?testerman ?free)
  )
  :effect (and
    (task-in ?t ?next_s) (not(task-in ?t ?previous_s))
    (not(role-is ?testerman ?free))
    (assigned-to ?t ?testerman)  
  )
)

(:action test_task_slow
  :parameters (?testerman - tester_jr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?testerman)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-finalize ?t ?previous_s)
  )
  :effect (and
    (role-is ?testerman ?free)
    (not(assigned-to ?t ?testerman))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (test-slow ?testerman ?t))
  )
)

(:action test_task_medium
  :parameters (?testerman - tester_ssr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?testerman)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-finalize ?t ?previous_s)
  )
  :effect (and
    (role-is ?testerman ?free)
    (not(assigned-to ?t ?testerman))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (test-medium ?testerman ?t))
  )
)

(:action test_task_fast
  :parameters (?testerman - tester_sr ?t - task ?previous_s ?next_s - state-task ?free - state-roles)
  :precondition (and
    (assigned-to ?t ?testerman)
    (task-in ?t ?previous_s)
    (next ?previous_s ?next_s)
    (can-finalize ?t ?previous_s)
  )
  :effect (and
    (role-is ?testerman ?free)
    (not(assigned-to ?t ?testerman))
    (task-in ?t ?next_s)
    (not(task-in ?t ?previous_s))
    (increase (total-cost) (test-fast ?testerman ?t))
  )
)

)
