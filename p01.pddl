(define (problem software_problem_1)
  (:domain software-development-process)

  (:objects 
    dev_jr_1 - dev_jr
    dev_sr_1 dev_sr_2 dev_sr_3 - dev_sr
    tester_jr - tester_jr
    tester_ssr - tester_ssr
    tester_sr - tester_sr
    t1 t2 - task
    creada asignada desarrollada testing finalizada - state-task
    libre ocupado - state-roles
  )

(:init

  (next creada asignada)
  (next asignada desarrollada)
  (next desarrollada testing)
  (next testing finalizada)

  (can-assign t1 creada)
  (can-develop t1 asignada)
  (can-test t1 desarrollada)
  (can-finalize t1 testing)
  
  (can-assign t2 creada)
  (can-develop t2 asignada)
  (can-test t2 desarrollada)
  (can-finalize t2 testing)

  (task-in t1 creada)
  (task-in t2 creada)

  (role-is dev_jr_1 libre) (role-is dev_sr_1 libre) (role-is dev_sr_2 libre) (role-is dev_sr_3 libre)
  (role-is tester_jr libre) (role-is tester_ssr libre) (role-is tester_sr libre)

  (= (work-slow dev_jr_1 t1) 22)
  (= (work-fast dev_sr_1 t1) 18) (= (work-fast dev_sr_2 t1) 18) (= (work-fast dev_sr_3 t1) 18)
  (= (work-slow dev_jr_1 t2) 17)
  (= (work-fast dev_sr_1 t2) 13) (= (work-fast dev_sr_2 t2) 13) (= (work-fast dev_sr_3 t2) 13)
  
  (= (test-fast tester_sr t1) 4)
  (= (test-medium tester_ssr t1) 5)
  (= (test-slow tester_jr t1) 7)

  (= (test-fast tester_sr t2) 2)
  (= (test-medium tester_ssr t2) 3)
  (= (test-slow tester_jr t2) 4)

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