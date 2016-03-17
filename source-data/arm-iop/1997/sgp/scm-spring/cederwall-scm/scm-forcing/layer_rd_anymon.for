      PROGRAM layer_rd_anymon
              integer :: NT, NP

      open(unit=1,file='layer_9704.dat',status='old')
      read(1,*)
      read(1,*)  NT
      read(1,*)
      read(1,*)  NP

      call read_plevs_time_profile_data(NT, NP)

      STOP
      END



      subroutine read_plevs_time_profile_data(NT, NP)

      real time(nt),      !Calenday day
     +     yy(nt),        !Year
     +     mo(nt),        !Month
     +     dd(nt),        !Day
     +     hh(nt),        !Hour
     +     mm(nt)         !Minutes
      real p(np)          !Pressure (mb)

      read(1,*)
      read(1,12)p
      read(1,*)
      read(1,12)time
      read(1,*)
      read(1,12)yy
      read(1,*)
      read(1,12)mo
      read(1,*)
      read(1,12)dd
      read(1,*)
      read(1,12)hh
      read(1,*)
      read(1,12)mm
12    format(5e15.7)
      read(1,*)
      read(1,*)nvar2
      print *,nt,np , nvar2

C  read the remainder of the file, i.e. profile data
      call read_profile_data(NT, NP, NVAR2)

      RETURN
      END

  

      subroutine read_profile_data(NT, NP, NVAR2)

      real d(nvar2,np,nt) !Multi-Layer fields as described below
c                         !-9999.0 is assigned to levels below the ground level

      character*50 var_name2(nvar2)
c     data var_name2/
c    +   'Temp_(K)',                        'H2O_Mixing_Ratio_(g/kg)',    
c    +   'u_wind_(m/s)',                    'v_wind_(m/s)',                
c    +   'omega_(mb/hour)',                 'Wind_Div_(1/s)',   
c    +   'Horizontal_Temp__Advec_(K/hour)', 'Vertical_T_Advec(K/hour)',
c    +   'Horizontal_q_Advec_(g/kg/hour)',  'Vertical_q_Advec(g/kg/hour)',
c    +   's(Dry_Static_Energy)(K)',         'Horizontal_s_Advec_(K/hour)',
c    +   'Vertical_s_Advec(K/hour)',        'ds/dt(K/hour)',       
c    +   'DT/dt(K/hour)',                   'dq/dt_(g/kg/hour)',   
c    +   'Q1_(k/hour)',                     'Q2_(g/kg/hour)',
c    +   'ARSCL_Cld'/ 

c All relevant variables represent area-means in a domain enclosed by the
c following 12 grids centered around the ARM Central Facility.
c (These 12 grids are boundary facilities, profiler stations and analysis grids)
c longitude
c   -97.2956     -98.3165     -99.0911     -99.3289     -99.2175     -98.5725
c   -97.5186     -96.5619     -95.8633     -95.5513     -95.6347     -96.3023
c latitude
c    38.3092      38.2207      37.6522      36.8885      36.0719      35.2734
c    34.9797      35.1246      35.6825      36.5223      37.3800      38.0408
c Central Facility
c   -97.4900      36.6100



      do i=1,nvar2
       read(1,11)var_name2(i)
       do j=1,np
        read(1,12)(d(i,j,k),k=1,nt)
       enddo
        print *,'You have just read the ', i, 'th field d(np,nt) as :'
        print *,'             ', var_name2(i)
      enddo
 11    format(a50)
 12    format(5e15.7)

      return
      end 


