program qlknn_test
    use qlknn_primitives
    use qlknn_disk_io
    implicit none
    integer :: n_trails, trial, verbosity, rho
    real, dimension(10,24) :: input
    real :: start, finish
    real, dimension(10) :: perturb
    real, dimension(24,7) :: qlknn_out
    namelist /test/ input
    print *, "Hello World!"
    open(10,file='test.nml',action='READ')
    read(10,nml=test)

    n_trails = 1
    verbosity = 0
#ifdef __PGI
    call load_all_nets_from_disk('/u/sim/QLKNN_networks', verbosity)
#else
    call load_all_nets_from_disk('.', verbosity)
#endif
    call cpu_time(start)
    do trial = 1,n_trails
        !perturb = 1e-1 * (/rand(), rand(), rand(), rand(), rand(), rand(), rand(), rand(), rand(), rand()/)
        !do rho = 1, 24
        !    input(:, rho) = input(:, rho) + perturb
        !end do
        call evaluate_QLKNN_10D(input, nets, rotdiv_nets, qlknn_out, verbosity)
    end do
    call cpu_time(finish)
    print '("Time = ",f9.3," milliseconds.")',1e3*(finish-start)/n_trails

end program qlknn_test
