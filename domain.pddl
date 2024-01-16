(define (domain software-development-process)
  (:requirements :typing :action-costs)
  (:types roles - object
	        developer tester - roles
   	      project task state expertise time - object
          state-project state-task - state
          time-limit time-required-dev time-required-test - time
  )

(:predicates 
  (project_started ?proj - project ?state_proj state)
  (project_done ?proj - project ?state_proj state)
  (developer_at ?dev - developer ?task_dev - task)
  (tester_at ?tester_c - tester ?task_tester - task)
  (task_is ?t - task ?state-t state-task)
  (is_workable ?t - task ?role - roles)

	(passenger-at ?person - passenger ?floor - count)
	(boarded ?person - passenger ?lift - elevator)
	(lift-at ?lift - elevator ?floor - count)
	(reachable-floor ?lift - elevator ?floor - count)
	(above ?floor1 - count ?floor2 - count)
	(passengers ?lift - elevator ?n - count)
	(can-hold ?lift - elevator ?n - count)
	(next ?n1 - count ?n2 - count)
)

(:functions (total-cost) - number
            (work-fast ?t - task ?e - expertise) - number
            (work-medium ?t - task ?e - expertise) - number
            (work-slow ?t - task ?e - expertise) - number
)

(:action start_project
  :parameters(?proj - project ?state_proj_c - state ?state_proj_s - state)
  :precondition (and (project_started ?proj ?state_proj) (not (project_done ?proj ?state_proj)))
  :effect ()
)

(:action develop_task
  :parameters(?dev - developer ?t - task ?initial_s - state ?final_s - state ?e - expertise)
  :preconditions (and (developer_at ?dev ?t) (task_is ?t ?initial_s) (not(task_is ?t ?final_s)) (is_workable ?t ?dev))
  :effect (and (task_is ?t ?final_s) (increase (total-cost) (work-medium ?t ?e))
)

(:action test_task
  :parameters
)

(:action assign_developer_to_task
  :parameters
)

(:action assign_tester_to_task
  :parameters
)

(:action finish_project
  :parameters
)

(:action move-up-slow
  :parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
  :precondition (and (lift-at ?lift ?f1) (above ?f1 ?f2 ) (reachable-floor ?lift ?f2) )
  :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-slow ?f1 ?f2))))

(:action move-down-slow
  :parameters (?lift - slow-elevator ?f1 - count ?f2 - count )
  :precondition (and (lift-at ?lift ?f1) (above ?f2 ?f1 ) (reachable-floor ?lift ?f2) )
  :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-slow ?f2 ?f1))))

(:action move-up-fast
  :parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
  :precondition (and (lift-at ?lift ?f1) (above ?f1 ?f2 ) (reachable-floor ?lift ?f2) )
  :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-fast ?f1 ?f2))))

(:action move-down-fast
  :parameters (?lift - fast-elevator ?f1 - count ?f2 - count )
  :precondition (and (lift-at ?lift ?f1) (above ?f2 ?f1 ) (reachable-floor ?lift ?f2) )
  :effect (and (lift-at ?lift ?f2) (not (lift-at ?lift ?f1)) (increase (total-cost) (travel-fast ?f2 ?f1))))

(:action board
  :parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
  :precondition (and  (lift-at ?lift ?f) (passenger-at ?p ?f) (passengers ?lift ?n1) (next ?n1 ?n2) (can-hold ?lift ?n2) )
  :effect (and (not (passenger-at ?p ?f)) (boarded ?p ?lift) (not (passengers ?lift ?n1)) (passengers ?lift ?n2) ))

(:action leave 
  :parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
  :precondition (and  (lift-at ?lift ?f) (boarded ?p ?lift) (passengers ?lift ?n1) (next ?n2 ?n1) )
  :effect (and (passenger-at ?p ?f) (not (boarded ?p ?lift)) (not (passengers ?lift ?n1)) (passengers ?lift ?n2) ))
  
)

