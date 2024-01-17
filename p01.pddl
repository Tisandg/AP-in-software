(define (problem software_problem_1)
  (:domain software-development-process)

  (:objects 
    dev_jr_1 - dev_jr
    dev_sr_1 dev_sr_2 dev_sr_3 - dev_sr
    tester_jr - tester_jr
    tester_ssr - tester_ssr
    tester_sr - tester_sr
    t1 t2 t3 t4 t5 - task
    creada en_desarrollo desarrollada en_evaluacion finalizada - state-task
    libre ocupado - state-roles
  )

(:init

  (next creada en_desarrollo)
  (next en_desarrollo desarrollada)
  (next desarrollada en_evaluacion)
  (next en_evaluacion finalizada)

  (can-assign t1 creada) (can-assign t2 creada) (can-assign t3 creada)
  (can-assign t4 creada) (can-assign t5 creada)

  (can-develop t1 en_desarrollo) (can-develop t2 en_desarrollo) (can-develop t3 en_desarrollo)
  (can-develop t4 en_desarrollo) (can-develop t5 en_desarrollo)

  (can-test t1 desarrollada) (can-test t2 desarrollada) (can-test t3 desarrollada)
  (can-test t4 desarrollada) (can-test t5 desarrollada)

  (can-finalize t1 en_evaluacion) (can-finalize t2 en_evaluacion) (can-finalize t3 en_evaluacion)
  (can-finalize t4 en_evaluacion) (can-finalize t5 en_evaluacion)

  (task-in t1 en_desarrollo) (task-in t2 en_desarrollo) (task-in t3 en_desarrollo)
  (task-in t4 creada) (task-in t5 creada)

  (role-in dev_jr_1 libre) (role-in dev_sr_1 ocupado) (role-in dev_sr_2 ocupado)
  (role-in dev_sr_3 ocupado) (role-in tester_jr libre) (role-in tester_ssr libre)
  (role-in tester_sr libre)

  (not (assigned-to t1 dev_jr_1  )) (assigned-to t1 dev_sr_1) (not (assigned-to t1 dev_sr_2 ))
  (not (assigned-to t1 dev_sr_3  )) (not (assigned-to t1 tester_jr))
  (not (assigned-to t1 tester_ssr)) (not (assigned-to t1 tester_sr))

  (not (assigned-to t2 dev_jr_1 )) (not (assigned-to t2 dev_sr_1 )) (assigned-to t2 dev_sr_2)
  (not (assigned-to t2 dev_sr_3 )) (assigned-to t2 tester_jr) (not (assigned-to t2 tester_ssr ))
  (not (assigned-to t2 tester_sr))

  (not (assigned-to t3 dev_jr_1)) (not (assigned-to t3 dev_sr_1 )) (not(assigned-to t3 dev_sr_2))
  (assigned-to t3 dev_sr_3) (not (assigned-to t3 tester_jr )) (not(assigned-to t3 tester_ssr))
  (not (assigned-to t3 tester_sr ))

  (not (assigned-to t4 dev_jr_1)) (not (assigned-to t4 dev_sr_1 )) (not (assigned-to t4 dev_sr_2))
  (not (assigned-to t4 dev_sr_3)) (not (assigned-to t4 tester_jr)) (not (assigned-to t4 tester_ssr))
  (not (assigned-to t4 tester_sr))

  (not (assigned-to t5 dev_jr_1 )) (not (assigned-to t5 dev_sr_1 )) (not (assigned-to t5 dev_sr_2  ))
  (not (assigned-to t5 dev_sr_3 )) (not (assigned-to t5 tester_jr)) (not (assigned-to t5 tester_ssr))
  (not (assigned-to t5 tester_sr))

  (not (can-work dev_jr_1 t1)) (can-work dev_sr_1 t1) (not (can-work dev_sr_2 t1))
  (not (can-work dev_sr_3 t1)) (not (can-work tester_jr t1)) (not (can-work tester_ssr t1))
  (not (can-work tester_sr t1))

  (not (can-work dev_jr_1 t2)) (not (can-work dev_sr_1 t2)) (can-work dev_sr_2 t2)
  (not (can-work dev_sr_3 t2)) (not (can-work tester_jr t2)) (not (can-work tester_ssr t2))
  (not (can-work tester_sr t2))

  (not (can-work dev_jr_1 t3)) (not (can-work dev_sr_1 t3)) (not (can-work dev_sr_2 t3))
  (can-work dev_sr_3 t3) (not (can-work tester_jr t3)) (not (can-work tester_ssr t3))
  (not (can-work tester_sr t3))

  (not (can-work dev_jr_1 t4)) (not (can-work dev_sr_1 t4)) (not (can-work dev_sr_2 t4))
  (not (can-work dev_sr_3 t4)) (not (can-work tester_jr t4)) (not (can-work tester_ssr t4))
  (not (can-work tester_sr t4))

  (not (can-work dev_jr_1 t5 )) (not (can-work dev_sr_1 t5)) (not (can-work dev_sr_2 t5))
  (not (can-work dev_sr_3 t5 )) (not (can-work tester_jr t5)) (not (can-work tester_ssr t5))
  (not (can-work tester_sr t5))

  (= (work-fast dev_sr_1 t1) 18) (= (work-fast dev_sr_1 t2) 13) (= (work-fast dev_sr_1 t3) 6)
  (= (work-fast dev_sr_1 t4) 14) (= (work-fast dev_sr_1 t5) 2)
  (= (work-fast dev_sr_2 t1) 18) (= (work-fast dev_sr_2 t2) 13) (= (work-fast dev_sr_2 t3) 6)
  (= (work-fast dev_sr_2 t4) 14) (= (work-fast dev_sr_2 t5) 2)
  (= (work-fast dev_sr_3 t1) 18) (= (work-fast dev_sr_3 t2) 13) (= (work-fast dev_sr_3 t3) 6)
  (= (work-fast dev_sr_3 t4) 14) (= (work-fast dev_sr_3 t5) 2)
  (= (work-slow dev_jr_1 t1) 22) (= (work-slow dev_jr_1 t2) 17) (= (work-slow dev_jr_1 t3) 10)
  (= (work-slow dev_jr_1 t4) 18) (= (work-slow dev_jr_1 t5) 6)

  (= (test-fast tester_sr t1) 18)    (= (test-fast tester_sr t2) 13)    (= (test-fast tester_sr t3) 6)
  (= (test-fast tester_sr t4) 14)    (= (test-fast tester_sr t5) 2)
  (= (test-medium tester_ssr t1) 22) (= (test-medium tester_ssr t2) 17)
  (= (test-medium tester_ssr t3) 10) (= (test-medium tester_ssr t4) 18) (= (test-medium tester_ssr t5) 6)
  (= (test-slow tester_jr t1) 22)    (= (test-slow tester_jr t2) 17)    (= (test-slow tester_jr t3) 10)
  (= (test-slow tester_jr t4) 18)    (= (test-slow tester_jr t5) 6)

  (= (total-cost) 0)

)

(:goal
  (and
    (task-in t1 finalizada)
    (task-in t2 finalizada)
    (task-in t3 finalizada)
    (task-in t4 finalizada)
    (task-in t5 finalizada)
  )
)

(:metric minimize (total-cost))

)