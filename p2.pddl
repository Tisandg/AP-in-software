(define (problem software_problem_2)
  (:domain software-development-process)

  (:objects 
    dev_jr_1 dev_jr_2 dev_jr_3 dev_jr_4 dev_jr_5 - dev_jr
    dev_ssr_1 dev_ssr_2 dev_ssr_3 - dev_ssr
    dev_sr_1 dev_sr_2 - dev_sr
    tester_jr_1 tester_jr_2 - tester_jr
    tester_ssr_1 - tester_ssr
    t1 t2 t3 t4 t5 t6 t7 - task
    creada asignada desarrollada testing finalizada - state-task
    libre - state-roles
  )

(:init

  (next creada asignada) (next asignada desarrollada) (next desarrollada testing) (next testing finalizada)

  (can-assign t1 creada) (can-develop t1 asignada) (can-test t1 desarrollada) (can-finalize t1 testing)
  (can-assign t2 creada) (can-develop t2 asignada) (can-test t2 desarrollada) (can-finalize t2 testing)
  (can-assign t3 creada) (can-develop t3 asignada) (can-test t3 desarrollada) (can-finalize t3 testing)
  (can-assign t4 creada) (can-develop t4 asignada) (can-test t4 desarrollada) (can-finalize t4 testing)
  (can-assign t5 creada) (can-develop t5 asignada) (can-test t5 desarrollada) (can-finalize t5 testing)
  (can-assign t6 creada) (can-develop t6 asignada) (can-test t6 desarrollada) (can-finalize t6 testing)
  (can-assign t7 creada) (can-develop t7 asignada) (can-test t7 desarrollada) (can-finalize t7 testing)

  (task-in t1 creada)
  (task-in t2 creada)
  (task-in t3 creada)
  (task-in t4 creada)
  (task-in t5 creada)
  (task-in t6 creada)
  (task-in t7 creada)

  (role-is dev_jr_1 libre) (role-is dev_jr_2 libre) (role-is dev_jr_3 libre) (role-is dev_jr_4 libre) (role-is dev_jr_5 libre)
  (role-is dev_ssr_1 libre) (role-is dev_ssr_2 libre) (role-is dev_ssr_3 libre)
  (role-is dev_sr_1 libre) (role-is dev_sr_2 libre)

  (role-is tester_jr_1 libre) (role-is tester_jr_2 libre)
  (role-is tester_ssr_1 libre)

  (= (work-slow dev_jr_1 t1) 20)
  (= (work-slow dev_jr_2 t1) 20)
  (= (work-slow dev_jr_3 t1) 20)
  (= (work-slow dev_jr_4 t1) 20)
  (= (work-slow dev_jr_5 t1) 20)

  (= (work-slow dev_jr_1 t2) 15)
  (= (work-slow dev_jr_2 t2) 15)
  (= (work-slow dev_jr_3 t2) 15)
  (= (work-slow dev_jr_4 t2) 15)
  (= (work-slow dev_jr_5 t2) 15)

  (= (work-slow dev_jr_1 t3) 7)
  (= (work-slow dev_jr_2 t3) 7)
  (= (work-slow dev_jr_3 t3) 7)
  (= (work-slow dev_jr_4 t3) 7)
  (= (work-slow dev_jr_5 t3) 7)

  (= (work-slow dev_jr_1 t4) 30)
  (= (work-slow dev_jr_2 t4) 30)
  (= (work-slow dev_jr_3 t4) 30)
  (= (work-slow dev_jr_4 t4) 30)
  (= (work-slow dev_jr_5 t4) 30)

  (= (work-slow dev_jr_1 t5) 35)
  (= (work-slow dev_jr_2 t5) 35)
  (= (work-slow dev_jr_3 t5) 35)
  (= (work-slow dev_jr_4 t5) 35)
  (= (work-slow dev_jr_5 t5) 35)

  (= (work-slow dev_jr_1 t6) 18)
  (= (work-slow dev_jr_2 t6) 18)
  (= (work-slow dev_jr_3 t6) 18)
  (= (work-slow dev_jr_4 t6) 18)
  (= (work-slow dev_jr_5 t6) 18)

  (= (work-slow dev_jr_1 t7) 15)
  (= (work-slow dev_jr_2 t7) 15)
  (= (work-slow dev_jr_3 t7) 15)
  (= (work-slow dev_jr_4 t7) 15)
  (= (work-slow dev_jr_5 t7) 15)

  (= (work-medium dev_ssr_1 t1) 15)
  (= (work-medium dev_ssr_2 t1) 15)
  (= (work-medium dev_ssr_3 t1) 15)

  (= (work-medium dev_ssr_1 t2) 12)
  (= (work-medium dev_ssr_2 t2) 12)
  (= (work-medium dev_ssr_3 t2) 12)

  (= (work-medium dev_ssr_1 t3) 5)
  (= (work-medium dev_ssr_2 t3) 5)
  (= (work-medium dev_ssr_3 t3) 5)

  (= (work-medium dev_ssr_1 t4) 25)
  (= (work-medium dev_ssr_2 t4) 25)
  (= (work-medium dev_ssr_3 t4) 25)

  (= (work-medium dev_ssr_1 t5) 30)
  (= (work-medium dev_ssr_2 t5) 30)
  (= (work-medium dev_ssr_3 t5) 30)

  (= (work-medium dev_ssr_1 t6) 15)
  (= (work-medium dev_ssr_2 t6) 15)
  (= (work-medium dev_ssr_3 t6) 15)

  (= (work-medium dev_ssr_1 t7) 12)
  (= (work-medium dev_ssr_2 t7) 12)
  (= (work-medium dev_ssr_3 t7) 12)

  (= (work-fast dev_sr_1 t1) 10)
  (= (work-fast dev_sr_2 t1) 10)

  (= (work-fast dev_sr_1 t2) 10)
  (= (work-fast dev_sr_2 t2) 10)

  (= (work-fast dev_sr_1 t3) 3)
  (= (work-fast dev_sr_2 t3) 3)

  (= (work-fast dev_sr_1 t4) 20)
  (= (work-fast dev_sr_2 t4) 20)

  (= (work-fast dev_sr_1 t5) 25)
  (= (work-fast dev_sr_2 t5) 25)

  (= (work-fast dev_sr_1 t6) 12)
  (= (work-fast dev_sr_2 t6) 12)

  (= (work-fast dev_sr_1 t7) 10)
  (= (work-fast dev_sr_2 t7) 10)

  (= (test-slow tester_jr_1 t1) 10)
  (= (test-slow tester_jr_2 t1) 10)

  (= (test-slow tester_jr_1 t2) 15)
  (= (test-slow tester_jr_2 t2) 15)

  (= (test-slow tester_jr_1 t3) 6)
  (= (test-slow tester_jr_2 t3) 6)

  (= (test-slow tester_jr_1 t4) 20)
  (= (test-slow tester_jr_2 t4) 20)

  (= (test-slow tester_jr_1 t5) 25)
  (= (test-slow tester_jr_2 t5) 25)

  (= (test-slow tester_jr_1 t6) 18)
  (= (test-slow tester_jr_2 t6) 18)

  (= (test-slow tester_jr_1 t7) 25)
  (= (test-slow tester_jr_2 t7) 25)

  (= (test-medium tester_ssr_1 t1) 8)
  (= (test-medium tester_ssr_1 t2) 12)
  (= (test-medium tester_ssr_1 t3) 4)
  (= (test-medium tester_ssr_1 t4) 18)
  (= (test-medium tester_ssr_1 t5) 22)
  (= (test-medium tester_ssr_1 t6) 15)
  (= (test-medium tester_ssr_1 t7) 22)

  

  (= (total-cost) 0)

)

(:goal
  (and
    (task-in t1 finalizada)
    (task-in t2 finalizada)
    (task-in t3 finalizada)
    (task-in t4 finalizada)
    (task-in t5 finalizada)
    (task-in t6 finalizada)
    (task-in t7 finalizada)
  )
)

(:metric minimize (total-cost))

)