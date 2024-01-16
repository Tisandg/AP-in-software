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
    (task-in ?t - task ?state-t state-task)
    (role-is ?r - roles ?s state-roles)
    (assigned-to ?t - task ?individual-roles)
    (next ?s1 - state ?s2 - state)
    (can-work ?r - roles ?t - task)
  )

  (:functions (total-time) - number
              (work-fast ?dev - developer ?t - task) - number
              (work-medium ?dev - developer ?t - task) - number
              (work-slow ?dev - developer ?t - task) - number
              (test-fast ?testman - tester ?t - task) - number
              (test-medium ?testman - tester ?t - task) - number
              (test-slow ?testman - tester ?t - task) - number
  )

  (:action assign_developer_to_task
    :parameters (?dev - developer ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?dev ?free)  (not(role-is ?dev ?bussy))  (not(assigned-to ?t ?dev))  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (not(can-work ?dev ?t))  (next ?previous_s ?next_s))
    :effects (and (role-is ?dev ?bussy) (not(role-is ?dev ?free)) (assigned-to ?t ? dev) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (can-work ?dev ?t))
  )

  (:action develop_task_slow
    :parameters (?dev - dev_jr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?dev ?t)  (next ?previous_s ?next_s))
    :effects ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ? dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (not(can-work ?dev ?t)) (increase (total-time) (work-slow ?previous_s ?next_s)) )
  )

  (:action develop_task_medium
    :parameters (?dev - dev_ssr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?dev ?t)  (next ?previous_s ?next_s))
    :effects ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ? dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (not(can-work ?dev ?t)) (increase (total-time) (work-medium ?previous_s ?next_s)) )
  )

  (:action develop_task_fast
    :parameters (?dev - dev_sr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?dev ?bussy)  (not(role-is ?dev ?free))  (assigned-to ?t ?dev)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?dev ?t) (next ?previous_s ?next_s) )
    :effects ( and (role-is ?dev ?free) (not(role-is ?dev ?bussy)) (not (assigned-to ?t ? dev)) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (not(can-work ?dev ?t)) (increase (total-time) (work-fast ?previous_s ?next_s)) )
  )

  (:action assign_tester_to_task
    :parameters (?testerman - tester ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?testerman ?free)  (not(role-is ?testerman ?bussy))  (not(assigned-to ?t ?testerman))  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (not(can-work ?dev ?t)) (next ?previous_s ?next_s) )
    :effects (and (role-is ?testerman ?bussy) (not(role-is ?testerman ?free)) (assigned-to ?t ?testerman) (task-in ?t ?next_s)  (not (task-in ?t ?previous_s)) (can-work ?testerman ?t))
  )

  (:action test_task_slow
    :parameters (?testerman - tester_jr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?testerman ?t) (next ?previous_s ?next_s))
    :effects ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (not(can-work ?testerman ?t)) (increase (total-time) (test-slow ?previous_s ?next_s)) )
  )

  (:action test_task_medium
    :parameters (?testerman - tester_ssr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions (and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?testerman ?t)  (next ?previous_s ?next_s) )
    :effects ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (not(can-work ?testerman ?t)) (increase (total-time) (test-medium ?previous_s ?next_s)) )
  )

  (:action test_task_fast
    :parameters (?testerman - tester_sr ?t - task ?previous_s - state-task ?next_s - state-task ?free - state-roles ?bussy - state-roles)
    :preconditions ( and (role-is ?testerman ?bussy)  (not(role-is ?testerman ?free))  (assigned-to ?t ?testerman)  (task-in ?t ?previous_s)  (not(task-in ?t ?next_s))  (can-work ?testerman ?t) (next ?previous_s ?next_s) )
    :effects ( and (role-is ?testerman ?free) (not (role-is ?testerman ?bussy)) (not (assigned-to ?t ?testerman)) (not (task-in ?t ?previous_s)) (task-in ?t ?next_s) (not(can-work ?testerman ?t)) (increase (total-time) (test-fast ?previous_s ?next_s)) )
  )

)