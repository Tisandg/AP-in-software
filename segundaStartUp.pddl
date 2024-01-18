(define (problem software_problem_2)
  (:domain software-development-process)

  (:objects 
    dev_jr_1 dev_jr_2 dev_jr_3 dev_jr_4 dev_jr_5 - dev_jr
    dev_ssr_1 dev_ssr_2 dev_ssr_3 - dev_ssr
    dev_sr_1 dev_sr_2 - dev_sr
    tester_jr_1 tester_jr_2 - tester_jr
    tester_ssr_1 - tester_ssr
    t1 t2 - task
    creada asignada desarrollada testing finalizada - state-task
    libre - state-roles
  )

(:init

  (next creada asignada) (next asignada desarrollada) (next desarrollada testing) (next testing finalizada)

  (can-assign t1 creada) (can-develop t1 asignada) (can-test t1 desarrollada) (can-finalize t1 testing)
  (can-assign t2 creada) (can-develop t2 asignada) (can-test t2 desarrollada) (can-finalize t2 testing)

  (task-in t1 creada)
  (task-in t2 creada)

  (role-is dev_jr_1 libre) (role-is dev_jr_2 libre) (role-is dev_jr_3 libre) (role-is dev_jr_4 libre) (role-is dev_jr_5 libre) (role-is dev_sr_1 libre) (role-is dev_sr_2 libre) (role-is dev_ssr_1 libre)
  (role-is dev_ssr_2 libre) (role-is dev_ssr_3 libre) (role-is tester_jr_1 libre) (role-is tester_jr_2 libre) (role-is tester_ssr_1 libre)

  (= (work-slow dev_jr_1 t1) 22)
  (= (work-fast dev_sr_1 t1) 18) (= (work-fast dev_sr_2 t1) 18) (= (work-fast dev_sr_3 t1) 18)
  (= (work-slow dev_jr_1 t2) 17)
  (= (work-fast dev_sr_1 t2) 13) (= (work-fast dev_sr_2 t2) 13) (= (work-fast dev_sr_3 t2) 13)
  
  (= (test-fast tester_sr_1 t1) 4)
  (= (test-medium tester_ssr_1 t1) 5)
  (= (test-slow tester_jr_1 t1) 7)

  (= (test-fast tester_sr_1 t2) 2)
  (= (test-medium tester_ssr_1 t2) 3)
  (= (test-slow tester_jr_1 t2) 4)

  (= (total-cost) 0)

)

(:goal
  (and
    (task-in t1 finalizada)
    (task-in t2 finalizada)
  )
)

(:metric minimize (total-cost))

)